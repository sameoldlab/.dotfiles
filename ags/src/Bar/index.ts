import { Hyprland, Notifications, Mpris, SystemTray}  from '../services/index.js'
import { Widget, Utils, Variable} from '../imports.js'
import Workspaces from './workspaces.js'
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

const mpris = {
  playing: false,
  player: Mpris.getPlayer(''),
  media: ''

}

const props = [
  'bus-name',
  'name',
  'identity',
  'entry',
  'trackid',
  'track-artists',
  'track-title',
  'track-cover-url',
  'cover-path',
  'play-back-status',
  'can-go-next',
  'can-go-prev',
  'can-play',
  'shuffle-status',
  'loop-status',
  'volume',
  'length',
  'position',
]

Mpris.connect('player-added', (_, bus) => {
  const player = Mpris.getPlayer(bus)
  const closure = function(prop) {
      let i = 0
      return function(player) {
          print(player.name, prop, player[prop], i++)
      }
  }

  // player.connect('changed', closure('name'));
  for (const prop of props) {
      player.connect(`notify::${prop}`, closure(prop))
  }
})
const mp = Variable({},{
  
})

/* Mpris.connect('player-added', (_, bus) => {
  Mpris.getPlayer(bus).connect('changed', player => {
      print(player.name, 'changed to ', player.play_back_status,' ', player.track_title)
  })
}) */

const Media = () =>  Widget.Button({
    class_name: 'media',
    on_primary_click: () => {
      print('register click')
      return Mpris.getPlayer('')?.playPause()
    },
    on_scroll_up: () => Mpris.getPlayer('')?.next(),
    on_scroll_down: () => Mpris.getPlayer('')?.previous(),
    child: Widget.Box({
      children:[ 
        Widget.Revealer({
          reveal_child: false,
          transition_duration: 1000,
          transition: 'slide_left',
          connections: [
            /* START Important section */
            [Mpris, self => {
              const players = Mpris.players
              let player = players[0]
              //prioritize players
              if (players.length > 1 ) {
                // very lazy but I'll probably always have
                // browser open before media player
                player = players[1]
              }
              print(player.name, 'changed to ', player.play_back_status,' ', player.track_title)
              if (player && player.play_back_status !== "Paused") {
                print('reveal')
                self.reveal_child = true;
                Utils.timeout(3000, () => self.reveal_child = false)							
              } else {
                print('void')
                // reveal_child will be true for 3 seconds unless this is enabled
                // self.reveal_child = false; // gets triggered on second event 
              }
            }, 'player-added' ],
          ],
          /* ^^^ Important section ^^^*/
          child: Widget.Label({
            connections: [
              [Mpris, self => {
                  const player = Mpris.getPlayer('')
                  // mpris player can be undefined
                  if (player)
                    self.label = `${player.track_artists.join(', ')} - ${
                      player.track_title.substring(0, 15)} `
                },
              ],
            ],
          })
        }),
        //yet another connection to track play or paused state?
        Widget.Icon('media-playback-start-symbolic'), 
        // Widget.Box() //todo: seekbar, select source, 
    ]
    }),
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
    // Media(),
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
