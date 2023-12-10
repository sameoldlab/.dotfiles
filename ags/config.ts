import { subprocess, exec } from 'resource:///com/github/Aylur/ags/utils.js'
import App from 'resource:///com/github/Aylur/ags/app.js'
import Bar from './src/Bar.js'
import Launcher from './src/Launcher.js'
import SettingsToast from './src/SettingsToast/index.js'

// import {NotificationsPopupWindow, NotificationCenter} from './src/Toast/index.js'

const scss = App.configDir + '/style/index.scss'
const css = App.configDir + '/style/index.css'
exec(`sassc ${scss} ${css}`)

subprocess(
	[
		'inotifywait',
		'--recursive',
		'--event',
		'create,modify',
		'-m',
		App.configDir + '/style',
	],
	() => {
		exec(`sassc ${scss} ${css}`)
		App.resetCss()
		App.applyCss(css)
	}
)

export default {
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
}
