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
		max_value: 1,
		min_value: 0,
		css: 'min-width: 0px',
		value: onScreenIndicator.bind('value')
	})
	
	onScreenIndicator.connect('popup', (_, value: number, icon: string) => {
		service.icon = icon
		// level.value = (value)
	// console.log("osi value: ", icon)
	})

	return Widget.Window({
		name: 'osiNotify',
		setup(self) { self.visible = false },
		visible: onScreenIndicator.bind('visible'),
		margins: [128, 0],
		anchor: ['bottom'],
		layer: 'overlay',
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
