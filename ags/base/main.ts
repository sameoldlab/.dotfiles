import PopLauncher from './popLauncher.js'
import Bar from './Bar/index.js'
import osiNotify from './osiNotify.js'
import { globalServices } from './services/index.js'
import app from 'ags/gtk4/app'
import { exec, execAsync } from 'ags/process'
import { monitorFile } from 'ags/file'

globalServices()
const scss = app.configDir + '/style/index.scss'
const css = app.cconfigDir + '/style/index.css'
execAsync(`sassc ${scss} ${css}`)

monitorFile(scss, () => {
	exec(`sassc ${scss} ${css}`)
	app.reset_css()
	app.apply_css(css)
}
)

app.config({
	notificationPopupTimeout: 3000, // milliseconds
	notificationForceTimeout: true,
	cacheNotificationActions: true,
	maxStreamVolume: 1.5, // float
	style: css,
	// iconTheme: 'Pop',
	windows: [
		Bar,
		PopLauncher,
		osiNotify,
		// NotificationsPopupWindow,
		// NotificationCenter,
	],
})
