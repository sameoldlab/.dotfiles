import {
	Bar,
	Launcher,
	PopLauncher,
	// SettingsToast,
	// QuickSettings
} from './windows.js'
// import {NotificationsPopupWindow, NotificationCenter} from './src/Toast/index.js'

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
		'window-name': 200, // milliseconds
	},
	notificationPopupTimeout: 3000, // milliseconds
	notificationForceTimeout: true,
	cacheNotificationActions: true,
	maxStreamVolume: 1.5, // float
	style: css,
	iconTheme: 'Pop',
	windows: [
		Bar,
		Launcher,
		PopLauncher,
		// SettingsToast,
		// NotificationsPopupWindow,
		// NotificationCenter,
	],
})