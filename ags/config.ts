import { Variable } from 'resource:///com/github/Aylur/ags/variable.js';
import { subprocess, exec } from 'resource:///com/github/Aylur/ags/utils.js'
import App from 'resource:///com/github/Aylur/ags/app.js'
import Bar from './src/Bar/index.js'
import Launcher from './src/Launcher.js'

const scss = App.configDir + '/style/index.scss';
const css = App.configDir + '/style/index.css';
exec(`sassc ${scss} ${css}`)


/* const bar = Widget.Window({
    name: `bar`,
    anchor: ['top', 'left', 'right'],
    exclusive: true,
    child: Widget.CenterBox({
        start_widget: Widget.Label({
            // hpack: 'center',
            label: 'Welcome to AGS!',
        }),
        end_widget: Widget.Label({
            // hpack: 'center',
            binds: [['label', time]],
        }),
    }),
		// connections: [
		// [10000, ags => {	
		// // print("reload css")
		// // exec(`sassc ${scss} ${css}`);
		// // App.resetCss();
		// // App.applyCss(css);;
		// }]
	// ],
}) */

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
		Launcher
	]
}
