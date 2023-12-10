// import { Notifications } from 'src/services/index';
import { Widget, App, Utils } from '../imports.js'
/* Notifications.connect('changed', (n) => {
    // n.getNotification()
});
const Toast = () => Widget.Box({});
export default Toast; */

import {
	NotificationList,
	DNDSwitch,
	ClearButton,
	PopupList,
} from './widgets.js'

const Header = () =>
	Widget.Box({
		className: 'header',
		children: [
			Widget.Label('Do Not Disturb'),
			DNDSwitch(),
			Widget.Box({ hexpand: true }),
			ClearButton(),
		],
	})

export const NotificationCenter = Widget.Window({
	name: 'notification-center',
	anchor: ['right', 'top', 'bottom'],
	popup: true,
	focusable: true,
	child: Widget.Box({
		children: [
			Widget.EventBox({
				hexpand: true,
				connections: [
					['button-press-event', () => App.closeWindow('notification-center')],
				],
			}),
			Widget.Box({
				vertical: true,
				children: [Header(), NotificationList()],
			}),
		],
	}),
})

export const NotificationsPopupWindow = Widget.Window({
	name: 'popup-window',
	anchor: ['top'],
	child: PopupList(),
})

Utils.timeout(500, () =>
	Utils.execAsync([
		'Utils.notify-send',
		'Notification Center example',
		'To have the panel popup run "ags toggle-window notification-center"' +
			'\nPress ESC to close it.',
	]).catch(console.error)
)
