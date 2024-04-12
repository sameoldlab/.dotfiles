import { onScreenIndicator } from './services/index.js'

const indicator = Variable({
	visible: false,
	icon: '',
	value: -1,
})

onScreenIndicator.connect('popup', (_, value, icon) => {
	indicator.setValue({
		visible: value && value !== -1,
		icon,
		value,
	})
})

const osiNotify = Widget.Window({
	name: 'osiNotify',
	visible: indicator.bind('value').as(v => v.visible),
	margins: [128, 0],
	anchor: ['bottom'],
	css: 'background: black; border-radius: 16px',
	child: Widget.Box({
		class_names: ['sys-toast'],
		vertical: false,
		margin: 4,
		spacing: 8,
		css: 'margin: 2em;',
		children: [
			Widget.Icon({
				size: 24,
				icon: indicator.bind('value').as(v => v.icon),
			}),
			Widget.LevelBar({
				widthRequest: 120,
				value: indicator.bind('value').as(v => v.value),
			}),
		],
	}),
})

export default osiNotify
