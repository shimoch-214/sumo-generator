import axios from 'axios'

const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
const instance = axios.create({
  headers: {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN': csrfToken
  },
})
export default instance
