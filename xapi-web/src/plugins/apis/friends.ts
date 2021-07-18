import http from '@/plugins/FetchApi'
export const friendLinks=() => {
  return http.get('/friend/links')
}
