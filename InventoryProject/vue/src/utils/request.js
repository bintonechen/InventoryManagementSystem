import axios from 'axios'
import router from "@/router";

// create a new axios object
const request = axios.create({
    baseURL: 'http://localhost:9090',   // Backend API address ip:port
    timeout: 30000
})

// request interceptor
// process before sending the request (token)
request.interceptors.request.use(config => {
    config.headers['Content-Type'] = 'application/json;charset=utf-8';
    let user = JSON.parse(localStorage.getItem("currentUser") || '{}')
    config.headers['token'] = user.token  // set request headers

    return config
}, error => {
    console.error('request error: ' + error) // for debug
    return Promise.reject(error)
});


// response interceptor
// handle the results uniformly after the interface responds
request.interceptors.response.use(
    response => {
        let res = response.data;

        // Compatible with string data returned by the server
        if (typeof res === 'string') {
            res = res ? JSON.parse(res) : res
        }
        if(res.code === '401'){
            router.push('/login')
        }
        return res;
    },
    error => {
        console.error('response error: ' + error) // for debug
        return Promise.reject(error)
    }
)

export default request