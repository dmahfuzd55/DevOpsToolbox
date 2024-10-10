import http from 'k6/http';


export let options = {
  vus: 10,
  duration: '10s',
};

// Define the API endpoint and request body
const apiUrl = 'http://172.30.30.114:8999/auth/token/';
const requestBody = {
  "username": "TP23001",
  "password": "admin1234",
  "client_id": "N53Q1opUqNHDN5bdVf5h6bzWDg5RGtdeCSrRmVNx",
  "client_secret": "3KI8DTyRfiqejXwq5JtJ6VAsMXiFL5ub4HIdIdOOVarjqVbq0fcZJeUCcBiHo2dJs4Y8QxCqM9XbiKeTmYEMY9o1LDjiWyYDeLUuuSysx94ssdJpbHUhv8vPm4SaBmw7",
  "grant_type": "password"
};

// Define the options for the POST request
const params = {
  headers: {
    'Content-Type': 'application/json',
  },
};

export default function () {
  // Send the POST request
  const response = http.post(apiUrl, JSON.stringify(requestBody), params);

  // Check the response
  if (response.status === 200) {
    /* console.log('POST request was successful'); */
    // You can add more checks here based on the response content
  } else {
    console.error('POST request failed with status code: ' + response.status);
  }
}