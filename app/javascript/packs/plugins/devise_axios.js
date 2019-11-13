import axios from 'axios'
import * as Cookies from 'js-cookie'

const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

const removeCookies = () => {
  Cookies.remove('headerAccessToken')
  Cookies.remove('headerClient')
  Cookies.remove('headerUid')
  Cookies.remove('headerExpiry')
}

const setHeaders = (headers) => {
  headers['access-token'] = Cookies.get('headerAccessToken')
  headers['client'] = Cookies.get('headerClient')
  headers['uid'] = Cookies.get('headersUid')
  return headers
}

const setCookie = (key, value) => {
  Cookies.set(key, value, { secure: false })
}

const setCookies = (headers) => {
  setCookie('headerClient', headers['client'])
  setCookie('headerUid', headers['uid'])
  if (headers['access-token']) {
    setCookie('headerAccessToken', headers['access-token'])
  }
  if (headers['expiry']) {
    setCookie('headerExpiry', headers['expiry'])
  }
}

const instance = axios.create({
  headers: {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN': csrfToken
  },
})

instance.interceptors.request.use((config) => {
  config.headers = setHeaders(config.headers)
  return config
}, (error) => {
  return Promise.reject(error)
})

instance.interceptors.response.use((response) => {
  setCookies(response.headers)
  return response
}, (error) => {
  removeCookies()
  return Promise.reject(error)
})

export default instance
