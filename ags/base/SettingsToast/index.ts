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
  visible: false,
  margins: [128, 0 ],
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
              binds: [['icon', indicator, 'value', value => value.icon]],
          }),
          Widget.LevelBar({
              widthRequest: 120,
              binds: [['value', indicator, 'value', value => value.value]],
          }),
      ]
  }),
  binds: [['visible', indicator, 'value', value => value.visible]],
}).keybind("ESCAPE", () => App.closeWindow('settingsToast'));


export default settingsToast
