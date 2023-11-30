import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

const Workspaces = () => Widget.Box({
	className: 'workspaces',
	connections: [[Hyprland.active.workspace, self => {
			// generate an array [1..10] then make buttons from the index
			const arr = Array.from({ length: 10 }, (_, i) => i + 1);
			self.children = arr.map(i => Widget.Button({
					onClicked: () => execAsync(`hyprctl dispatch workspace ${i}`),
					child: Widget.Label(`${i}`),
					className: Hyprland.active.workspace.id == i ? 'focused' : '',
			}));
	}]],
});

export default Workspaces