import Widget from 'resource:///com/github/Aylur/ags/widget.js'
import { subprocess, interval, exec } from 'resource:///com/github/Aylur/ags/utils.js'
import Variable from 'resource:///com/github/Aylur/ags/variable.js'
import Battery from 'resource:///com/github/Aylur/ags/service/battery.js'
import App from 'resource:///com/github/Aylur/ags/app.js'

const date = Variable(exec('date'))
date.connect('changed', ({ value }) => {
	print(`date is ${value}`)
})

const pactl = Variable(
	{ count: 0, msg: '' },
	{
		listen: [
			'pactl subscribe',
			msg => ({
				count: (pactl.value.count += 2),
				msg,
			}),
		],
	}
)

pactl.connect('changed', ({ value }) => {
	print(value.msg, value.count)
})
const label = Widget.Label({
	connections: [
		[
			pactl,
			self => {
				const { count, msg } = pactl.value
				self.label = `${msg} ${count}`
			},
		],
	],
})

// widgets are GObjects too
label.connect('notify::label', ({ label }) => {
	print('label changed to ', label)
})

const batteryProgress = Widget.CircularProgress({
	className: 'progress',
	child: Widget.Icon({
		binds: [['icon', Battery, 'icon-name']],
	}),
	connections: [
		[
			Battery,
			self => {
				self.value = Battery.percent / 100
			},
		],
	],
})

const bar = Widget.Window({
	name: 'bar',
	anchor: ['top', 'left', 'right'],
	child: batteryProgress,
})

const scss = App.configDir + '/style.scss'
const css = App.configDir + '/style.css'
exec(`sassc ${scss} ${css}`);

subprocess([
	'inotifywait',
	'--recursive',
	'--event', 'create,modify',
	'-m', App.configDir + '/scss',
], () => {
/* 	const scss = App.configDir + '/style.scss';
	const css = App.configDir + '/style.css'; */
	exec(`sassc ${scss} ${css}`);
	App.resetCss();
	App.applyCss(css);
});



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
		// Array<Gtk.Window>
	],
}
