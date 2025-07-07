import { Gtk } from "ags/gtk4";
const { Orientation } = Gtk
import { createPoll } from "ags/time";
import { createState } from "ags";

export default () => {
  let [hide, setHide] = createState(false)
  const datetime = createPoll("", 1000, "date -R").as(dt => new Date(dt))
  const day = datetime(d => d.getDate().toString().padStart(2, '0'))
  const hr = datetime(d => d.toLocaleTimeString().split(':')[0].padStart(2, '0'))
  const min = datetime(d => d.getMinutes().toString().padStart(2, '0'))
  const sec = datetime(d => d.getSeconds().toString().padStart(2, '0'))

  return <button
    onClicked={(self) => {
      setHide(!hide)
      // self.toggleClassName('hide', hide)
    }}>
    <box
      class={'clock semibold'}
      spacing={4}
      orientation={Orientation.HORIZONTAL}
    >
      <label
        halign={Gtk.Align.START}
        class={'date semibold'}
        vexpand={true}
        label={day}
      />
      <label
        class={'time semibold'}
        halign={Gtk.Align.START}
        vexpand={true}
        justify={Gtk.Justification.LEFT}
        // vpack: 'end',
        label={hr}
      />
      <label
        class={'time semibold'}
        halign={Gtk.Align.START}
        vexpand={true}
        justify={Gtk.Justification.LEFT}
        // vpack: 'end',
        label={min}
      />
      <label
        class={'time semibold'}
        halign={Gtk.Align.START}
        vexpand={true}
        justify={Gtk.Justification.LEFT}
        // vpack: 'end',
        label={sec}
      />
    </box>

  </button>
}
