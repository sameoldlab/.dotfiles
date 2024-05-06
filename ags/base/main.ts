import PopLauncher from './popLauncher.js'
import Bar from './Bar/index.js'
import osiNotify from './osiNotify.js'
import { globalServices } from './services/index.js'

globalServices()
const scss = App.configDir + '/style/index.scss'
const css = App.configDir + '/style/index.css'
Utils.execAsync(`sassc ${scss} ${css}`)

Utils.monitorFile(scss, () => {
		Utils.exec(`sassc ${scss} ${css}`)
		App.resetCss()
		App.applyCss(css)
	}
)

App.config({
	notificationPopupTimeout: 3000, // milliseconds
	notificationForceTimeout: true,
	cacheNotificationActions: true,
	maxStreamVolume: 1.5, // float
	style: css,
	// iconTheme: 'Pop',
	windows: [
		Bar,
		// Launcher,
		PopLauncher,
		osiNotify,
		// NotificationsPopupWindow,
		// NotificationCenter,
	],
})
