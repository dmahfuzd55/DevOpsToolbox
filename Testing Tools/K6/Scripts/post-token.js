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

    // Extract the access token from the token response
    const accessToken = JSON.parse(tokenResponse.body).access_token;

    /* console.log('Token Response Status:', tokenResponse.status); */
    /* console.log('Token Response Body:', accessToken).body; */

    // Define the API endpoint for the subsequent request
    const apiEndpoint = 'http://172.30.30.119:7788/playground/v7/Account/EnquireDepositAccount';

    // Define the headers for the subsequent request with the access token
    const apiHeaders = {
        'Authorization': `Bearer ${accessToken}`,
        'Content-Type': 'application/json',
        // Add other required headers for the subsequent request
    };

    // Define the data to send in the subsequent request (if needed)
    const postData = {
        "AcctNum": "1102000083429"
        /* header: {
            Uid: "43249123432",
        },
        data: {
            "AcctNum": "1102000083429",
        }, */ // Replace with your actual data object
    };

    // Send the subsequent request with the access token
    const apiResponse = http.post(apiEndpoint, JSON.stringify(postData), { headers: apiHeaders });

    // You can add checks/assertions on the subsequent response if needed
    // For example, check response status code, response body, etc.
    if (apiResponse.status === 200) {
        /* console.log('API request was successful'); */
    } else {
        console.error('API request failed with status code: ' + apiResponse.body);
    }

    // Optional: Sleep to simulate user think time
    sleep(1); // Sleep for 1 second between iterations
}