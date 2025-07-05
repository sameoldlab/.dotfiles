import app from "ags/gtk4/app"
import style from "./style/index.scss"
import Bar from "./base/Bar4"

app.start({
  css: style,
  main() {
    app.get_monitors().map(Bar)
  },
})
