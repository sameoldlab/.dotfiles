import { Variable, Widget } from "../imports.js"
import { onScreenIndicator } from '../services/index.js'

const indicator = Variable({
	visible: false,
	icon: '',
	value: -1
})

onScreenIndicator.connect('popup', (_, value, icon)=>{
	indicator.setValue({
		visible: value && value !== -1,
		icon,
		value
	})
})

const settingsToast = Widget.Window({
	name: 'settingsToast',
	popup: true,
	visible: false,

	margins: [128, 0],
	anchor: ['bottom'],
	css: 'background: black; border-radius: 12px',
	child: Widget.Box({
		class_names: ['sys-toast'],
		vertical: true,
		margin: 16,
		css: 'margin: 2em;',
		children: [
			Widget.Icon({
				size: 160,
				binds: [['icon', indicator, 'value', value => value.icon]],
			}),
			Widget.Slider({
				
				binds: [['value', indicator, 'value', value => value.value]],
			}),
		]
	}),
	binds: [['visible', indicator, 'value', value => value.visible]],
})

export default settingsToast