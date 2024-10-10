import http from 'k6/http';
import { sleep } from 'k6';

const vus = __ENV.VUS || 1;
const duration = __ENV.DURATION || '1s';


function generateUniqueTransactionID(vuNumber) {
    const randomPart = Math.floor(Math.random() * 1000000);
    const uniqueTransactionID = `${vuNumber}_${randomPart}`;
    return uniqueTransactionID;
}

export let options = {
    vus: vus,
    duration: duration,
};

export default function () {

    const vuNumber = __VU;

    const uniqueTransactionID = generateUniqueTransactionID(vuNumber);
    console.log(uniqueTransactionID);

    const accessToken = `eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiJhNmFhZjE0Zi02NTVkLTQ2MDQtOTNjYi1iMzdkMDA0NDM2MjkiLCJzdWIiOiIxNCIsImlhdCI6MTY5NjkxNDQyOCwiZXhwIjoxNjk2OTE4MDI4fQ.d4eYZZvoq8IsyzQwBnwPvBToN-OjC5wsoI16fGzH-1MsfVqttDKjFws-ekESVHi8B7tT2Cv9rRcAdVH0pyLSKg`;

    const apiEndpoint = 'http://172.30.30.114:8999/api/V2/MTO/TransactionPayload/';

    const apiHeaders = {
        'Authorization': `Bearer ${accessToken}`,
        'Content-Type': 'application/json',

    };

    const postData = {
        "VALIDATED_ID": "97945140128102021130006",
        "SENDER_DOCUMENT_TYPE": "PASSPORT",
        "SENDER_DOCUMENT_NUMBER": "123456789",
        "SENDER_OCCUPATION": "DRIVER",
        "SENDER_SOURCE_OF_FUND": "SALARY",
        "SENDER_RELATION_WITH_RECEIVER": "ewe",
        "RECEIVING_CURRENCY": "USD",
        "PAYMENT_FOREX_RATE": "66",
        "PURPOSE_OF_TRANSACTION": "ydgasjdh",
        "PIN_NO": "37453855453",
        "AGENT_ID": "45454",
        "AGENT_PC_IP": "129.168.1.129",
        "AGENT_PC_NAME": "data",
        "AGENT_PC_MAC": "54543545555",
        "AGENT_NAME": "mong",
        "REMIT_DATE_TIME": "2017-10-05 17:44:26"
    };

    const apiResponse = http.post(apiEndpoint, JSON.stringify(postData), { headers: apiHeaders });

    if (apiResponse.status === 202) {
        const responseBody = JSON.parse(apiResponse.body);
        console.log('Response Message: ' + responseBody.VALIDATED_ID);
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