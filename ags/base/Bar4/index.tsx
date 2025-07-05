import { Astal, Gdk, Gtk } from "ags/gtk4";
import app from "ags/gtk4/app";
import { execAsync } from "ags/process";
import { createPoll } from "ags/time";
import { Workspaces } from "./workspaces";
import { createState } from "ags";
const { Align, Orientation } = Gtk

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const time = createPoll("", 1000, "date -R").as(Date)
  // const date = Variable(new Date(0)).poll(1000, "date -R", (d) => new Date(d))
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor

  return <window
    visible
    name="bar"
    class="Bar"
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={RIGHT | TOP | BOTTOM}
    application={app}
  >
    <centerbox
      orientation={Orientation.VERTICAL}
    >
      {/*
       <button
        $type="start"
        hexpand
        halign={Align.CENTER}
      >
        <label label="Welcome to AGS!" />
      </button>
      */ }
      <box $type="center" />

      <box $type="center" >
        <Workspaces />
      </box>

      <menubutton $type="end" class={"p-4"} hexpand halign={Align.START}>
        <Clock />
        <popover>
          <Gtk.Calendar />
        </popover>
      </menubutton>

    </centerbox>

  </window>
}

export const Clock = () => {
  let [hide, setHide] = createState(false)
  const datetime = createPoll("", 1000, "date -R").as(dt => new Date(dt))
  const day = datetime(d => d.getDay().toString().padStart(2, '0'))
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
      orientation={Orientation.VERTICAL}
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
