import { Player } from '../services/index.js'
import { Widget } from '../imports.js'

const Media = () =>  Widget.Button({
    class_name: 'media',
    on_primary_click: () => Player.value.player?.playPause(),
    on_scroll_up: () => Player.value.player?.next(),
    on_scroll_down: () => Player.value.player?.previous(),
    child: Widget.Box({
      children:[ 
        Widget.Revealer({
          reveal_child: false,
          transition_duration: 1000,
          transition: 'slide_left',
					binds: [['reveal-child', Player, 'value', v => v.reveal]],
          child: Widget.Label({
						binds: [['label', Player, 'value', v => v.media]],
          })
        }),
        Widget.Icon({
					binds: [['icon', Player, 'value', v => v.icon]]
				}), 
        // Widget.Box() //todo: seekbar, select source, 
    ]
    }),
})

export default Media
