import { App } from "astal/gtk3"
import style from "./style/index.scss"
import { Bar } from "./base/Bar"

App.start({
  css: style,
  main() {
    Bar
  },
})
