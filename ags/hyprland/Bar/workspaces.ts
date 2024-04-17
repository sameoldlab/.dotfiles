import { Hyprland } from '../services/index.js'



const Workspaces = () => 	Widget.Box({
	className: 'workspaces',
	child: Widget.EventBox({
		on_scroll_up: () => Utils.execAsync('hyprctl dispatch workspace +1'),
		on_scroll_down: () => Utils.execAsync('hyprctl dispatch workspace -1'),
		child: Widget.Box({
			children: [...Array(10)].map((_,i) => {
				i++
			return Widget.Button({
			on_clicked: () => Utils.execAsync(`hyprctl dispatch workspace ${i}`).catch(print),
			child: Widget.Label({
				label: `${i}`,
				className: 'indicator',
			}),
			connections: [[Hyprland, btn => {
				btn.toggleClassName('focused', Hyprland.active.workspace.id === i)
				btn.toggleClassName('occupied', Hyprland.getWorkspace(i)?.windows > 0)
			}]]
			})
		})
		})
	})
})


export default Workspaces
