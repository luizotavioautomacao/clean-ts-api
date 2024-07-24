import 'module-alias/register'
import env from '@/main/config/env'
import { MongoHelper } from '@/infra/db'
import https from 'https'
import fs from 'fs'
import 'dotenv/config'

const options = {
  key: fs.readFileSync('/etc/letsencrypt/live/gotech.education/privkey.pem'),
  cert: fs.readFileSync('/etc/letsencrypt/live/gotech.education/fullchain.pem')
}

MongoHelper.connect(env.mongoUrl)
  .then(async () => {
    const { setupApp } = await import('./config/app')
    const app = await setupApp()
    https.createServer(options, app).listen(env.port, () =>
      console.log(`Server running at https://localhost:${env.port}`)
    )
  })
  .catch(console.error)
