import Bar from './Bar.js'
import {
	Launcher,
	SettingsToast,
	QuickSettings
} from '../base/windows.js'

const scss = App.configDir + '/style/index.scss'
const css = App.configDir + '/style/index.css'
Utils.exec(`sassc ${scss} ${css}`)

Utils.subprocess(
	[
		'inotifywait',
		'--recursive',
		'--event',
		'create,modify',
		'-m',
		App.configDir + '/style',
	],
	() => {
		Utils.exec(`sassc ${scss} ${css}`)
		App.resetCss()
		App.applyCss(css)
	}
)

App.config({
	closeWindowDelay: {
		'window-name': 500, // milliseconds
	},
	notificationPopupTimeout: 3000, // milliseconds
	notificationForceTimeout: true,
	cacheNotificationActions: true,
	maxStreamVolume: 1.5, // float
	style: css,
	windows: [
		Bar,
		Launcher,
		SettingsToast,
		// NotificationsPopupWindow,
		// NotificationCenter,
	],
})
