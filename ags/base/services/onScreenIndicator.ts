import icons from '../utils/icons.js'
import Audio from 'gi://AstalMpris'
import Brightness from './brightness.js'

const getAudioTypeIcon = (icon: string | null): string => {
	const subs = new Map([
		['audio-headset-bluetooth', icons.audio.type.headset],
		['audio-card-analog-usb', icons.audio.type.speaker],
		['audio-card-analog-pci', icons.audio.type.card],
	])

	return icon && subs[icon] ? subs[icon] : icons.audio.type.speaker
}

class Indicator extends Service {
	static {
		Service.register(
			this,
			{
				popup: ['float', 'string'],
			},
			{
				visible: ['boolean', 'r'],
				icon: ['string', 'r'],
				value: ['float', 'r']
			}
		)
	}

	constructor() {
		super()
	}

	#visible = false
	#icon = ''
	#value = 0

	get icon() {
		return this.#icon
	}
	get visible() {
		return this.#visible
	}
	get value() {
		return this.#value
	}

	// every setTimeout blocks the main thread. pick the largest step you can where there's still time to interupt
	#delay = 0
	singleton = 0
	async close(id = 0) {
		if (id < this.singleton) return
		this.#delay--
		if (this.#delay > 0 && this.#visible === true) {
			await new Promise(res => setTimeout(res, 100)) /* delay * 100ms = 1.5s */
			return this.close(id)
		}

		this.singleton = 0
		this.#visible = false
		this.changed('visible')
	}

	popup(value, icon) {
		this.#visible = true
		this.#icon = icon
		this.#value = value
		this.emit('changed')
		this.notify('value')
		this.notify('visible')
		this.emit('popup', value, this.#icon)

		this.#delay = 15
		this.singleton++
		this.close(this.singleton)
		return 1
	}

	speaker() {
		if (!Audio.speaker)
			throw Error('Indicator.speaker() error: Audio.speaker does not exist')

		return this.popup(
			(Audio.speaker.volume / 1.5),
			getAudioTypeIcon(Audio.speaker.icon_name)
		)
	}

	display() {
		// brightness is async, so lets wait a bit
		return Utils.timeout(5, () =>
			this.popup(Brightness.screen_value, icons.brightness.screen)
		)
	}

	connect(event = 'popup', callback) {
		return super.connect(event, callback)
	}
}

const indicator = new Indicator()

export default indicator
