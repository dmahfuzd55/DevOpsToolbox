import http from 'k6/http';
import { sleep } from 'k6';

const vus = __ENV.VUS || 1;
const duration = __ENV.DURATION || '1s';

export let options = {
    vus: vus,
    duration: duration,
};

export default function () {
   
    const accessToken = __ENV.ACCESS_TOKEN;

    const apiEndpoint = 'http://172.30.30.114:8999/api/V2/MTO/GetTransactionStatus/';

    const apiHeaders = {
        'Authorization': `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
    };

    const postData = {
        "VALIDATED_ID": "248497751205102023130750",
        "TRANSACTION_ID": ""
    };

    const apiResponse = http.post(apiEndpoint, JSON.stringify(postData), { headers: apiHeaders });

    if (apiResponse.status === 202) {
        const responseBody = JSON.parse(apiResponse.body); 
        console.log('Response Message: ' + responseBody.RESPONSE_MESSAGE);
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