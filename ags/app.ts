import { App } from "astal/gtk3"
import style from "./style/index.scss"
import { Launcher } from './base/Launcher'
import { Bar } from "./base/Bar"
import { declareGlobals } from './base/globals'
App.start({
  css: style,
  instanceName: 'niri',
  main() {
    Bar()
    Launcher()
    declareGlobals()
  },
  requestHandler(request, response) {
    if (['audio', 'brightness', 'mpris'].indexOf(request.split('.')[0]) !== -1)
      App.eval(request).then(console.log).catch(console.error)

  }
})
