import { Hyprland, Notifications, SystemTray}  from '../services/index.js'
import { Widget, Utils, } from '../imports.js'
import Workspaces from './workspaces.js'
import Media from './media.js'
import SysTray from './systray.js'
import GLib from 'gi://GLib'
import icons from '../icons.js'

const ClientTitle = () =>
  Widget.Label({
    class_name: 'client-title',
    binds: [['label', Hyprland.active.client, 'title']],
  });


const dayOfWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S']
let date = GLib.DateTime.new_now_local()
const Clock = () => Widget.Box({
    class_name: 'clock',
    vertical: true,
    hpack: 'end',
    children: [
        Widget.Label({
          class_name: 'time',
          justification: 'right',
          hexpand: true,
          connections: [[1000, self =>
            self.label = date.format('%I:%M %p'),
          ]],
        }),
        Widget.Label({
          class_name: 'date',
          hexpand: true,
          justification: 'right',
          connections: [[1000, self =>
            self.label = date.format('%a, %b %d')
          ]],
        })
    ],
    connections: [
      [
          1000,
          _ => date = GLib.DateTime.new_now_local()			
      ]
  ]
});

const Notification = () => 	Widget.Box({
  class_name: 'notification',
  children: [
    Widget.Icon({
      icon: 'preferences-system-notifications-symbolic',
      connections: [
        [
          Notifications,
          self => (self.visible = Notifications.popups.length > 0),
        ],
      ],
    }),
    Widget.Label({
      connections: [
        [
          Notifications,
          self => {
            self.label = Notifications.popups[0]?.summary || ''
          },
        ],
      ],
    }),
  ],
})

const ExtTray = () =>
  Widget.Box({
    connections: [
      [
        SystemTray,
        self => {
          self.children = SystemTray.items.map(item =>
            Widget.Button({
              child: Widget.Icon({ binds: [['icon', item, 'icon']] }),
              on_primary_click: (_, event) => item.activate(event),
              on_secondary_click: (_, event) => item.openMenu(event),
              binds: [['tooltip-markup', item, 'tooltip-markup']],
            })
          )
        },
      ],
    ],
})

// layout of the bar
const Left = () =>
Widget.Box({
  children: [
    Workspaces(),
  ],
})

const Center = () =>
Widget.Box({
  children: [
    Notification(),
  ],
})

const Right = () =>
Widget.Box({
  hpack: 'end',
  children: [
    Media(),
    ExtTray(),
    SysTray(),
    Clock(),
  ],
})

export default Widget.Window({
  name: `agsBar`, // name has to be unique
  class_name: 'bar',
  anchor: ['top', 'left', 'right'],
  exclusivity: "exclusive" /* Stops draw over */,
  child: Widget.CenterBox({
    start_widget: Left(),
    center_widget: Center(),
    end_widget: Right(),

  }),
  connections: [],
})
