import { App, Astal, Gtk, Gdk, Widget } from "astal/gtk3"
import { Variable, bind } from "astal"
import Niri from 'gi://AstalNiri'

const pad = (str = "", num = 10) => {
  const adding = num - str.length
  let padding = " "
  for (let i = 1; i < adding; i++) {
    padding += " "
  }
  return str + padding
}
export const Workspaces = () => {
  const niri = Niri.get_default()
  return new Widget.Box({
    vertical: true,
  },
    bind(niri, "workspaces").as((ws) => ws && ws.map((w) => {
      const vary = Variable(`name: ${pad(w.name ?? "")} | id: ${w.id} | focused: ${w.isFocused} | window: ${w.active_window_id} `)
      w.connect('changed', (w) => {
        console.log('ws changed')
        vary.set(`name: ${pad(w.name ?? "")} | id: ${pad(w.id.toString())} | focused: ${w.isFocused} | window: ${w.active_window_id} `)
      })

      return new Widget.Label({
        halign: Gtk.Align.START,
        label: vary()
      })
    }))
  )
}

const Windows = () => {
  const niri = Niri.get_default()
  return new Widget.Box({
    vertical: true,
    children: bind(niri, "windows").as((ws) => ws && ws.map((w) => {
      const vary = Variable(`name: ${pad(w.title ?? "")} | id: ${w.id} | focused: ${w.isFocused} | window: ${w.workspace_id} `)
      w.connect('changed', (w) => {
        console.log('changed')
        // console.log(`name: ${pad(w.title ?? "")} | id: ${w.id} | focused: ${w.isFocused} | window: ${w.workspace_id} `)
        vary.set(`name: ${pad(w.title ?? "")} | id: ${w.id} | focused: ${w.isFocused} | window: ${w.workspace_id} `)
      })
      return new Widget.Label({
        halign: Gtk.Align.START,
        label: vary()
      })
    }))
  })
}


const Outputs = () => new Widget.Box({

})


export const Demo = () => {
  return new Widget.Window({
    name: 'niri-demo',
    monitor: 0,
    anchor: Astal.WindowAnchor.RIGHT
      | Astal.WindowAnchor.LEFT
      | Astal.WindowAnchor.BOTTOM,
    application: App,
    exclusivity: Astal.Exclusivity.EXCLUSIVE,
  },
    new Widget.CenterBox({
      className: "niri-demo",
      start_widget: Workspaces(),
      center_widget: Windows(),
      end_widget: Outputs()
    },
    )
  )
}

//------------------------------------------
const niri = Niri.get_default()

// (Json.Node event)
// niri.connect('event', (n, j) => {
//   console.log('event')
// })

// (List<weak Workspace> workspaces);
// niri.connect('workspaces_changed', (n, j) => {
//   console.log('workspaces_changed')
// })
// (int64 workspace, bool focused);
niri.connect('workspace_activated', (n, j, fo) => {
  console.log('workspace_activated', j, fo)
})
// (int64 workspace, int64 window_id);
niri.connect('workspace_active_window_changed', (n, wrk_id, win_id) => {
  console.log('workspace_active_window_changed', wrk_id, win_id)
})
// (List<weak Window> windows);
niri.connect('windows_changed', (n, w) => {
  // console.log('windows_changed', w)
})
// (Window window);
niri.connect('window_changed', (n, w) => {
  // console.log('window_changed', w)
})
// (Window window);
niri.connect('window_opened', (n, w) => {
  // console.log('window_opened', w)
})
// (int64 id);
niri.connect('window_closed', (n, w) => {
  // console.log('window_closed', w)
})
// (uint64 window_id);
niri.connect('window_focus_changed', (n, win_id) => {
  // console.log('window_focus_changed', win_id)
})
niri.connect('keyboard_layouts_changed', (n, j) => {
  // console.log('keyboard_layouts_changed', j)
})
// )(uint8 idx);
niri.connect('keyboard_layout_switched', (n, j) => {
  // console.log('keyboard_layout_switched', j)
})

