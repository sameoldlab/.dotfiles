import {
	Hyprland,
	Notifications,
	SystemTray,
	onScreenIndicator,
} from '../base/services/index.js'
import Workspaces from './Bar/workspaces.js'
import { Center, Right } from '../base/Bar/index.js'

const ClientTitle = () =>
	Widget.Label({
		class_name: 'client-title',
		binds: [['label', Hyprland.active.client, 'title']],
	})


// layout of the bar
const Left = Widget.Box({
	children: [Workspaces()],
})


export default Widget.Window({
	name: `agsBar`, // name has to be unique
	class_name: 'bar',
	anchor: ['top', 'left', 'right'],
	exclusivity: 'exclusive' /* Stops draw over */,
	child: Widget.CenterBox({
		start_widget: Left,
		center_widget: Center,
		end_widget: Right,
	}),
})
