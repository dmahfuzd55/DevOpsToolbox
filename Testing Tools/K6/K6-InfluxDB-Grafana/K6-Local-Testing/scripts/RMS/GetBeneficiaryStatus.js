import http from 'k6/http';
import { sleep } from 'k6';



export let options = {
    vus: 1,
    duration: '1s',
};

export default function () {
   
    const accessToken = `eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIxZDQzZDQyYi04YzIyLTQ5ZDMtOTEwYS1hZGJiYzliZTczZDAiLCJzdWIiOiIxNCIsImlhdCI6MTY5NjUwMTM4MiwiZXhwIjoxNjk2NTA0OTgyfQ.J0trfMkFNNK_VnYGewe78dnCwy9r4dodA8fzInUJ-2_uLdG7znJKFGa5moI1SW1RRu_3izLUcYT9gNqtiLlQfg`;

    const apiEndpoint = 'http://172.30.30.114:8999/api/V2/MTO/GetBeneficiaryStatus/';

    const apiHeaders = {
        'Authorization': `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
    };

    const postData = {
        "VALIDATED_ID": "412602380705102023174944",
        "TRANSACTION_ID": "874678655456"
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