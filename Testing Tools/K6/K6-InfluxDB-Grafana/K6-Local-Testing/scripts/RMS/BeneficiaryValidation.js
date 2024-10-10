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

export default function () {

    const vuNumber = __VU;

    const uniqueTransactionID = generateUniqueTransactionID(vuNumber);
    console.log(uniqueTransactionID);

    const accessToken = `eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiI5ZDY2NGRjMi00M2IyLTQ4MjAtYTg0YS1iYjNkY2I1Y2FkNDMiLCJzdWIiOiIxNCIsImlhdCI6MTcwMjE4MjQzOSwiZXhwIjoxNzAyMTg2MDM5fQ.aOooPdX2gJHSUYyEnr5yV7tXkr7CJQQCKgZZDvakSQNiQZDcDNETHsMSq7hGeluor5ZBoeXooZDz3K1o46x63Q`;

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
        const responseBody = JSON.parse(apiResponse.body); 
        console.log('Response Message: ' + responseBody);
    }
    else if (apiResponse.status === 400) {
        const responseBody = JSON.parse(apiResponse.body); 
        console.log('Response Message: ' + responseBody.RESPONSE_MESSAGE);
    }
    else {
        console.error('API request failed with status code: ' + apiResponse.body);
    }

    sleep(1); 
}