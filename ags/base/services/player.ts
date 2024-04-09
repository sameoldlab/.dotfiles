import { Mpris } from './index.js'
import { MprisPlayer } from '../../types/service/mpris.js'


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
/**
 * Represents currently focused Player
 */
const current = Variable({
	reveal: false,
  playing: false,
  player: Mpris.getPlayer(''),
  media: '',
	icon: 'media-playback-start-symbolic'
})
const players: Map<string, MprisPlayer> = new Map()

current.value.player?.playPause()

Mpris.connect('player-added', (_, bus) => {
	const player = Mpris.getPlayer(bus)
	if(!player) return
	
	players.set(bus,player)
	/* const closure = function(prop) {
      let i = 0
      return function(player) {
          print(player.name, prop, player[prop], i++)
      }
  }
  // player.connect('changed', closure('name'));
  for (const prop of props) {
      player.connect(`notify::${prop}`, closure(prop))
  } */

	player.connect('notify::track-title',(media)=> {
		// Did track actually change? 
		// check media tracktitle, playbackstatus, and bus
		const val = current.getValue()
		print(media.play_back_status)
		current.setValue({
			...val,
			reveal: media.play_back_status === 'Playing',
			player: media,
			media: media.track_title + ' ', // use margin
			icon: `media-playback-${media.play_back_status === 'Playing'? 'pause':'start'}-symbolic`
		})
		Utils.timeout(3000, () => current.setValue({...current.getValue(), reveal: false}))
	} )
})

Mpris.connect('player-closed', (_,bus) => {
	print('bad bus', bus)
	if (current.value.player?.bus_name === bus) {
		print('current destroyed')
		let media = [...players][0][1]
		print(media.bus_name)
		print(media.name)
		print(media.track_title)
		
		const val = current.getValue()
		current.setValue({
			...val,
			player: media,
			media: media.track_title + ' ', // use margin
			//play-large-diabled-symbolic
			icon: `media-playback-${media.play_back_status === 'Playing'? 'pause':'start'}-symbolic`
		})
	}

	players.delete(bus)
})


export default current