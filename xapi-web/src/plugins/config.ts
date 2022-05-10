export function getApiUrl(str?:any) {

        const devArr = ['http://localhost:6300', 'localhost', 'yzq.xiaomy.net']
        const apiArr = ['http://localhost:6300']
        let localUrl = '192.168.'
        let isDev =
            devArr.includes(document.domain) || document.domain.includes(localUrl)
        let isProd = apiArr.includes(document.domain)


        if (str === 'socket') {
            if (isDev) {
                return 'wss://localhost:6300/ws'
            }

            if (isProd) {
                return 'wss://localhost:6300/ws'
            }
        }

        if (isDev) {
            return 'http://localhost:6300'
        }

        if (isProd) {
            return 'http://localhost:6300'
        }
        return ""

}
