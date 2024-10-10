import http from 'k6/http';


export let options = {
  vus: 10,
  duration: '10s',
};

const apiUrl = 'http://172.30.30.114:8999/auth/token/';
const requestBody = {
  "username": "TP23001",
  "password": "admin1234",
  "client_id": "N53Q1opUqNHDN5bdVf5h6bzWDg5RGtdeCSrRmVNx",
  "client_secret": "3KI8DTyRfiqejXwq5JtJ6VAsMXiFL5ub4HIdIdOOVarjqVbq0fcZJeUCcBiHo2dJs4Y8QxCqM9XbiKeTmYEMY9o1LDjiWyYDeLUuuSysx94ssdJpbHUhv8vPm4SaBmw7",
  "grant_type": "password"
};

const params = {
  headers: {
    'Content-Type': 'application/json',
  },
};

export default function () {
  const response = http.post(apiUrl, JSON.stringify(requestBody), params);

  if (response.status === 200) {
  } else {
    console.error('POST request failed with status code: ' + response.status);
  }
}