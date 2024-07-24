import express, { Express } from 'express'
import { resolve } from 'path'
const fallback = require('express-history-api-fallback')

const root = `/usr/src/${process.env.FRONT_END}/dist`

export default (app: Express): void => {
  app.use('/static', express.static(resolve(__dirname, '../../static')))
  app.use(express.static(root))
  console.log('root:', root)
  console.log('fallback:', fallback)
  app.use(fallback('index.html', { root }))
}
