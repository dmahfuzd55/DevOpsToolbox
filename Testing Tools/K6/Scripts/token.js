import http from 'k6/http';
import { sleep } from 'k6';

export let options = {
    vus: 10,
    duration: '10s',
};

export default function () {
    // Define the token URL
    const tokenUrl = 'http://172.30.30.122:1010/v7/token';

    // Define the credentials and other data required for the token request
    const formData = {
        username: 'Justpay',
        password: 'JustpayJbl@#4321',
        token_type: 'Transaction',
        grant_type: 'password',
        amount: '100',
        service_name: 'testservice',
        // Add other required parameters for token request
    };

    // Define the headers for the token request
    const tokenHeaders = {
        'Content-Type': 'application/x-www-form-urlencoded',
    };

    // Send the token request to obtain an access token
    const tokenResponse = http.post(tokenUrl, formData, { headers: tokenHeaders });

   
    if (tokenResponse.status === 200) {
        /* console.log('API request was successful' + tokenResponse.body); */
    } else {
        console.error('API request failed with status code: ' + tokenResponse.body);
    }

    // Optional: Sleep to simulate user think time
    sleep(1); // Sleep for 1 second between iterations */
}