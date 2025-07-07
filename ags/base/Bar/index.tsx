/* ==================================== 
 * SPDX-License-Identifier: MPL-2.0
 * ==================================== */

// import Media from './media.js'
import SysTray from './Systray.js'
import AstalTray from 'gi://AstalTray'
import Battery from 'gi://AstalBattery'
import { Astal, Gdk, Gtk } from "ags/gtk4";
import { createBinding, For } from "ags";
import app from 'ags/gtk4/app'
import Clock from './Clock'
import Workspaces from './Workspaces'


const BatteryLabel = () => {
	const bat = Battery.get_default()

	const level = createBinding(bat, 'percentage').as(p => Math.round(p * 100) + '%')
	const icon = createBinding(bat, 'battery_icon_name')
	const tooltip = createBinding(bat, 'time_to_empty').as(s => `naturalTime: ${s}`)

	return <box
		spacing={2}
		vexpand={true}
		class={'battery tray-icon'}
		tooltip_text={tooltip}
	>
		<image iconName={icon} />
		<label label={level} />
	</box>
}

/*
const Notification = () =>
	<box>({
		class_name: 'notification',
		children: [
			<icon>({
				icon: 'preferences-system-notifications-symbolic',
				visible: notifications.bind('popups').as(p => p.length > 0),
			}),
			<label>({
				label: notifications.bind('popups').as(p => p[0].summary),
			}),
		],
	})
*/

export const StatusNotifierItems = () => {
	const tray = AstalTray.get_default()
	const items = createBinding(tray, 'items')
	return <box>
		<For each={items}>{(item) =>
			<menubutton
				class={"tray-icon"}
				tooltip_markup={item.tooltip_markup}
				menu_model={item.menu_model}
				$={(self) => self.insert_action_group('dbusmenu', item.action_group)}
				onDestroy={(self) => self.run_dispose()}
			>
				<image gicon={createBinding(item, 'gicon')} />
			</menubutton>
		}</For>
	</box >
}

const Seperator = (label = ' |  ') => label

export const Bar = (monitor: Gdk.Monitor) => <window
	visible
	name="bar"
	class="Bar"
	gdkmonitor={monitor}
	exclusivity={Astal.Exclusivity.EXCLUSIVE}
	anchor={Astal.WindowAnchor.RIGHT | Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT}
	application={app}
>
	<centerbox>
		<box $type="start" >
			<Workspaces />
		</box>
		<box $type="center" >
			<Clock />
			{/*
					<Demo/>
					<Notification/>
				*/}
		</box>
		<box $type="end"
			halign={Gtk.Align.END}
		>
			<StatusNotifierItems />
			<BatteryLabel />
			{/*
					<Media/>
					<SysTray vertical={false} />
				*/}
		</box>
	</centerbox>
</window>

