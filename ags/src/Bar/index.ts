import { Hyprland, Notifications, Mpris, Audio, Battery, SystemTray, Brightness}  from '../services/index'
import {Widget, Utils} from '../imports'
import Workspaces from './workspaces';
import { BaseProps,  } from '../../types/widgets/widget';
import { CenterBoxProps } from '../../types/widgets/centerbox';




const ClientTitle = () =>
	Widget.Label({
		className: 'client-title',
		binds: [['label', Hyprland.active.client, 'title']],
	});

const dayOfWeek = ['S', 'M', 'T', 'W', 'T', 'F', 'S']

type NewType = BaseProps<CenterBoxProps>;

const Clock = (): NewType => Widget.Box({

	className: 'clock',
	vertical: true,
	hpack: 'end',
	tooltipText: 'date',
	children: [
		Widget.Label({
			className: 'time',
			justification: 'right',
			hexpand: true,
			connections: [
				[
					1000,
					self =>
						Utils.execAsync(['date', '+%I:%M%p'])
							.then(date => (self.label = date.toUpperCase()))
							.catch(console.error),
			]],
		}),

		Widget.Label({
			className: 'date',
			hexpand: true,
			justification: 'right',
			connections: [
				[
					1000000,
					self =>
						Utils.execAsync(['date', '+%x %a'])
							.then(date => (self.label = date))
							.catch(console.error),
			]]
		})
	]
})



const Wifi = () => Widget.Box({
	className: 'wifi tray-icon',
	children: [
		Widget.Stack({
			items: [
				// tuples of [string, Widget]
				['1', Widget.Icon('network-wireless-signal-good-symbolic')],
				['0', Widget.Icon('network-wireless-offline-symbolic')],
			],
			connections: [
				[
					1000, self => 
						Utils.execAsync([
							'bash',
							'-c',
							`iwctl station wlan0 show \
							 | grep 'Connected network' \
							 | sd '            Connected network     ' ''`, 
						]).then(s => (self.shown = s === '' ? '0' : '1'))
				],
			],
		}),
	]
})

// we don't need dunst or any other notification daemon
// because the Notifications module is a notification daemon itself
const Notification = () =>
	Widget.Box({
		className: 'notification',
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

const Media = () => Widget.Button({
		className: 'media',
		onPrimaryClick: () => Mpris.getPlayer('')?.playPause(),
		onScrollUp: () => Mpris.getPlayer('')?.next(),
		onScrollDown: () => Mpris.getPlayer('')?.previous(),
		child: Widget.Label({
			connections: [
				[
					Mpris,
					self => {
						const mpris = Mpris.getPlayer('')
						// mpris player can be undefined
						if (mpris)
							self.label = `${mpris.trackArtists.join(', ')} - ${
								mpris.trackTitle
							}`
						else self.label = 'Nothing is playing'
					},
				],
			],
		}),
	})

const Volume = () => Widget.Box({
	className: 'volume tray-icon',
	// css: 'min-width: 180px',
	children: [
		Widget.Stack({
			items: [
				// tuples of [string, Widget]
				['101', Widget.Icon('audio-volume-overamplified-symbolic')],
				['67', Widget.Icon('audio-volume-high-symbolic')],
				['34', Widget.Icon('audio-volume-medium-symbolic')],
				['1', Widget.Icon('audio-volume-low-symbolic')],
				['0', Widget.Icon('audio-volume-muted-symbolic')],
			],
			connections: [
				[
					Audio,
					self => {
						if (!Audio.speaker) return

						if (Audio.speaker.isMuted) {
							self.shown = '0'
							return
						}
						
						const {volume} = Audio.speaker

						const show = [101, 67, 34, 1, 0].find(
							threshold => threshold <= volume * 100
						)

						self.shown = `${show}`
					},
					'speaker-changed',
				],
			],
		}),
			Widget.Slider({
				hexpand: true,
				drawValue: false,
				onChange: ({ value }) => (Audio.speaker.volume = value),
				connections: [
					[
						Audio,
						self => {
							self.value = Audio.speaker?.volume || 0
						},
						'speaker-changed',
					],
				],
			}),
	],
})

const BrightnessLabel = () => Widget.Label({
	className: 'battery tray-icon',
	binds: [['label', Brightness, 'screen-value', v => `${v}`]],
	connections: [
		[
			Brightness,
			self => {
				self.label = `${Brightness.screen_value}`
			},
			'notify::screen-value',
		],
	],
})


const BatteryLabel = () => Widget.Box({
		className: 'battery tray-icon',
		children: [
			Widget.Icon({
				connections: [
					[
						Battery,
						self => {
							// print(Battery.time_remaining ) //units???
							self.icon = Battery.icon_name
						},
					],
				],
			}),
		],
	})

const SysTray = () =>
	Widget.Box({
		connections: [
			[
				SystemTray,
				self => {
					self.children = SystemTray.items.map(item =>
						Widget.Button({
							child: Widget.Icon({ binds: [['icon', item, 'icon']] }),
							onPrimaryClick: (_, event) => item.activate(event),
							onSecondaryClick: (_, event) => item.openMenu(event),
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
			// ClientTitle(),
		],
	})
	
	const Center = () =>
	Widget.Box({
		children: [Media(), Notification()],
	})
	
	const Right = () =>
	Widget.Box({
		hpack: 'end',
		children: [
			SysTray(),
			BrightnessLabel(),
			Wifi(),
			Volume(),
			BatteryLabel(),
			Clock()],
	})


export default Widget.Window({
	name: `agsBar`, // name has to be unique
	className: 'bar',
	anchor: ['top', 'left', 'right'],
	exclusivity: "exclusive" /* Stops draw over */,
	child: Widget.CenterBox({
		startWidget: Left(),
		centerWidget: Center(),
		endWidget: Right(),

	}),
	connections: [],
})