import onScreenIndicator from './services/onScreenIndicator.js'

const indicator = Variable({
	visible: false,
	icon: '',
	value: -1,
})

const osi = () => {
	const service = Widget.Icon({
		size: 24
	})
	const level = Widget.LevelBar({
		className: "osi_level",
		width_request: 100,		
	})
	
	onScreenIndicator.connect('popup', (_, value, icon) => {
		service.icon = icon
		level.value = value
	})

	return Widget.Window({
		name: 'osiNotify',
		visible: onScreenIndicator.bind('visible'),
		margins: [128, 0],
		anchor: ['bottom'],
		child: Widget.Box({
			class_names: ['sys-toast'],
			vertical: false,
			margin: 4,
			spacing: 8,
			children: [
				service,
				level
			],
		}),
	})
}

export default osi()
