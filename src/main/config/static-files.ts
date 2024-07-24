import express, { Express } from 'express'
import { resolve, join } from 'path'
import fallback from 'express-history-api-fallback'

const root = join(__dirname, `../${process.env.FRONT_END}/dist`)

export default (app: Express): void => {
  app.use('/static', express.static(resolve(__dirname, '../../static')))
  app.use(express.static(root))
  app.use(fallback('index.html', { root }))
}
