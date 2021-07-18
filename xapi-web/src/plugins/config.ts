export function getApiUrl(str?:any) {

        const devArr = ['test.researchstar.cn', 'localhost', 'yzq.xiaomy.net']
        const apiArr = ['www.researchstar.cn']
        let localUrl = '192.168.'
        let isDev =
            devArr.includes(document.domain) || document.domain.includes(localUrl)
        let isProd = apiArr.includes(document.domain)


        if (str === 'socket') {
            if (isDev) {
                return 'wss://dev.researchstar.cn/dobell-research/ws'
            }

            if (isProd) {
                return 'wss://api.researchstar.cn/dobell-research/ws'
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
