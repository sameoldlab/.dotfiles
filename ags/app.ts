#!/usr/bin/env -S ags run

// import app from "ags/gtk4/app"
import { App, Gdk, Gtk } from "astal/gtk3"
import style from "./style/index.scss"
import { Launcher } from './base/Launcher'
import { Bar } from "./base/Bar"
// import { Demo } from "./base/Demo"
import { declareGlobals } from './base/globals'
// import { osi } from "./base/osiNotify"

App.start({
  css: style,
  instanceName: 'niri',
  main() {
    const bars = new Map<Gdk.Monitor, Gtk.Widget>()

    for (const monitor of App.get_monitors()) {
      bars.set(monitor, Bar(monitor))
    }

    Launcher()
    // osi()
    declareGlobals()
    // Demo()
  },
  requestHandler(request, response) {
    if (['audio', 'brightness', 'mpris'].indexOf(request.split('.')[0]) !== -1)
      App.eval(request).then(res => {
        console.log(res)
        response(res)
      }).catch(response)
  }
})
