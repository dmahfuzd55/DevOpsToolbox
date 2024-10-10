import http from 'k6/http';
import { sleep } from 'k6';

function generateUniqueTransactionID(vuNumber) {
    const randomPart = Math.floor(Math.random() * 1000000); 
    const uniqueTransactionID = `${vuNumber}_${randomPart}`;
    return uniqueTransactionID;
}


export let options = {
    vus: 10,
    duration: '10s',
};

function validateBeneficiary() {
    const vuNumber = __VU;

    const uniqueTransactionID = generateUniqueTransactionID(vuNumber);
    console.log(uniqueTransactionID);

    const accessToken = `eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI0ZWZlMmMyYi0zZjg5LTRmMjQtYTBmMC0yOTdmZDM0MzRlNjIiLCJzdWIiOiIxNCIsImlhdCI6MTcwMTk1MTM2MiwiZXhwIjoxNzAxOTU0OTYyfQ.TcdO54fiEONEShSblBItPnkwDS5JXB7kBFEAxC6PCNHF9K6O2MToww64bgLIaCl2kWZ3fAk3ov97BIgA3ubqZA`;

    const apiEndpoint = 'http://172.30.30.114:8999/api/V2/MTO/BeneficiaryValidation/';

    const apiHeaders = {
        'Authorization': `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
        
    };

    const postData = {
        "INFO": {
            "MTO_ID": "TP23001",
            "TRANSACTION_ID": uniqueTransactionID,
            "SENDER_FIRSTNAME": "RAJU",
            "SENDER_LASTNAME": "AHMAD",
            "SENDER_COUNTRY": "SA",
            "SENDER_NATIONALITY": "SA",
            "SENDER_CITY": "JAZAN",
            "SENDER_ADDRESS": "Faisal Bin Fahad,Jazan 82722",
            "SENDER_MSISDN_NO": "+9665418565",
            "ACCOUNT_NAME": "Kazi Zubair Ahmed",
            "RECEIVER_ACCOUNT_NUMBER": "1102000024021",
            "RECEIVER_BANK_NAME": "Jamuna Bank",
            "RECEIVER_ROUTING_NUMBER": "130270005",
            "AMOUNT": "10.00",
            "PAYMENT_TYPE": "ACTRF",
            "PAYMENT_ENTITY": "BANK",
            "CUSTOMER_TYPE": "INDIVIDUAL",
            "RECEIVER_LIST": [
                {
                    "RECEIVER_FIRSTNAME": "KAZI",
                    "RECEIVER_LASTNAME": "ZUBAIR",
                    "RECEIVER_COUNTRY": "BD",
                    "RECEIVER_NATIONALITY": "BD",
                    "RECEIVER_DISTRICT": "DHAKA",
                    "RECEIVER_ADDRESS": "545/c, Mirpur,Dhaka-1216",
                    "RECEIVER_MSISDN_NO": "+8801671843760"
                }
            ]
        }
    };

    const apiResponse = http.post(apiEndpoint, JSON.stringify(postData), { headers: apiHeaders });

    if (apiResponse.status === 202) {
        const responseBody = JSON.parse(apiResponse.body); // Parse the JSON response
        console.log('Response Message: ' + responseBody.VALIDATED_ID);
        return responseBody.VALIDATED_ID;
    }
    else if (apiResponse.status === 400) {
        const responseBody = JSON.parse(apiResponse.body); // Parse the JSON response
        console.log('Response Message: ' + responseBody.RESPONSE_MESSAGE);
    }
    else {
        console.error('API request failed with status code: ' + apiResponse.body);
    }
}




export default function () {

    const vuNumber = __VU;

    const uniqueTransactionID = generateUniqueTransactionID(vuNumber);
    const validateResponse = validateBeneficiary();


    const accessToken = `eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI5MjhlZTg4Ny03ODMzLTQ2YzMtOTRjNy00MThiMzY5MzAwY2QiLCJzdWIiOiIxNCIsImlhdCI6MTY5NjgzMDg3MCwiZXhwIjoxNjk2ODM0NDcwfQ.kWud7lLavIYwYdhxHWuau9sUoWV4TpEvqGgeOc3cCt3Q_RlFf0JB9B2SvUoeXl_m7E1SId4JDF_7y6fKpI3HBw`;

    const apiEndpoint = 'http://172.30.30.114:8999/api/V2/MTO/GetBeneficiaryStatus/';

    const apiHeaders = {
        'Authorization': `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
    };

    const postData = {
        "VALIDATED_ID": validateResponse,
        "TRANSACTION_ID": uniqueTransactionID
    };

    const apiResponse = http.post(apiEndpoint, JSON.stringify(postData), { headers: apiHeaders });

    if (apiResponse.status === 202) {
        const responseBody = JSON.parse(apiResponse.body); 
        console.log('GetBeneficiaryStatus: ' + responseBody.RESPONSE_MESSAGE);
    }
    else if (apiResponse.status === 400) {
        const responseBody = JSON.parse(apiResponse.body); 
        console.log('GetBeneficiaryStatus: ' + responseBody.RESPONSE_MESSAGE);
    }
    else {
        console.error('GetBeneficiaryStatus: ' + apiResponse.body);
    }

    sleep(1); // 
}