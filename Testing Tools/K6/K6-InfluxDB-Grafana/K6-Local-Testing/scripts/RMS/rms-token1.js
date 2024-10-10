import http from 'k6/http';
import { sleep } from 'k6';

export let options = {
  vus: 10,
  duration: '10s',
};


const commonHeaders = {
  'Content-Type': 'application/json',
};


const commonRequestBody = {
  "username": "TP23001",
  "password": "admin1234",
  "client_id": "N53Q1opUqNHDN5bdVf5h6bzWDg5RGtdeCSrRmVNx",
  "client_secret": "3KI8DTyRfiqejXwq5JtJ6VAsMXiFL5ub4HIdIdOOVarjqVbq0fcZJeUCcBiHo2dJs4Y8QxCqM9XbiKeTmYEMY9o1LDjiWyYDeLUuuSysx94ssdJpbHUhv8vPm4SaBmw7",
  "grant_type": "password"
};

export default function () {
  
  const endpoint2 = 'http://172.30.30.114:8999/auth/token/';
  const response2 = http.post(endpoint2, JSON.stringify(commonRequestBody), {
    headers: commonHeaders,
  });

  
  if (response2.status === 200) {
    
  } else {
    console.error('Request to Endpoint 2 failed with status code: ' + response2.status);
  }

  sleep(1);
}