import { App, Astal, Gtk, Widget } from "astal/gtk3"
import { bind, Variable } from "astal"

const date = Variable("").poll(1000, "date")

export function Bar(monitor = 0) {
  return new Widget.Window(
    {
      className: "Bar",
      monitor: monitor,
      // exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor: Astal.WindowAnchor.TOP
        | Astal.WindowAnchor.LEFT
        | Astal.WindowAnchor.RIGHT,
      application: App
    },
    new Widget.CenterBox({
      centerWidget:
        new Widget.Button({
          onClicked: "echo hello",
          halign: Gtk.Align.CENTER
        },
          new Widget.Label({ label: 'Welcome to AGS!' })
        ),
      endWidget:
        new Widget.Button({
          onClicked: () => print("hello"),
          halign: Gtk.Align.CENTER
        },
          new Widget.Label({ label: bind(date).as(v => v) })
        )
    },
    )
  )
}
