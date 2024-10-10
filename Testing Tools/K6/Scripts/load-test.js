import http from 'k6/http';
import { sleep } from 'k6';

export default function () {
  const url = 'http://172.30.6.77:9000/currency';
  const response = http.get(url);

  if (response.status !== 200) {
    console.error(`Request failed with status code: ${response.status}`);
  }

  sleep(1);
}