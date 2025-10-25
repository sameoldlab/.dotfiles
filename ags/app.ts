/* ==================================== 
 * SPDX-License-Identifier: MPL-2.0
 * ==================================== */

import app from "ags/gtk4/app"
// import { Launcher } from './base/Launcher'
// import { Demo } from "./base/Demo"
import style from "./style/index.scss"
import { declareGlobals } from './base/globals'
// import { osi } from "./base/osiNotify"
import { Bar } from "./base/Bar"
import { Launcher } from "./base/nL"

app.start({
  css: style,
  instanceName: 'niri',
  main() {
    app.get_monitors().map(Bar)

    // Launcher()
    // osi()
    declareGlobals()
    // Demo()
  },
  requestHandler(request, response) {
    if (['audio', 'brightness', 'mpris'].indexOf(request.split('.')[0]) !== -1)
      app.eval(request).then(res => {
        console.log(res)
        response(res)
      }).catch(response)
  }
})

