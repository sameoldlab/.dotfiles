import Player from '../services/player.js'

const Media = () =>  Widget.Button({
    class_name: 'media',
    on_primary_click: () => Player.value.player?.playPause(),
    on_scroll_up: () => Player.value.player?.next(),
    on_scroll_down: () => Player.value.player?.previous(),
    child: Widget.Box({
      children:[ 
        Widget.Revealer({
          reveal_child: Player.bind().as(v => v.reveal),
          transition_duration: 1000,
          transition: 'slide_left',
          child: Widget.Label({
						label: Player.bind().as(v => v.media)
          })
        }),
        Widget.Icon({
					icon: Player.bind().as(v => v.icon)
				}), 
        // Widget.Box() //todo: seekbar, select source,
    ]
    }),
})

export default Media
