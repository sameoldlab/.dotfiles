import { Widget, Utils } from '../imports.js'

const NotificationIcon = ({ appEntry, appIcon, image }) => {
	if (image) {
		return Widget.Box({
			vpack: 'start',
			hexpand: false,
			className: 'icon img',
			css: `
                background-image: url("${image}");
                background-size: contain;
                background-repeat: no-repeat;
                background-position: center;
                min-width: 78px;
                min-height: 78px;
            `,
		})
	}

	let icon = 'dialog-information-symbolic'
	if (Utils.lookUpIcon(appIcon)) icon = appIcon

	if (Utils.lookUpIcon(appEntry)) icon = appEntry

	return Widget.Box({
		vpack: 'start',
		hexpand: false,
		className: 'icon',
		css: `
            min-width: 78px;
            min-height: 78px;
        `,
		children: [
			Widget.Icon({
				icon,
				size: 58,
				hpack: 'center',
				hexpand: true,
				vpack: 'center',
				vexpand: true,
			}),
		],
	})
}

export const Notification = n =>
	Widget.EventBox({
		className: `notification ${n.urgency}`,
		on_primary_click: () => n.dismiss(),
		properties: [['hovered', false]],
		on_hover: self => {
			if (self.hovered) return

			// if there are action buttons and they are hovered
			// EventBox onHoverLost will fire off immediately,
			// so to prevent this we delay it
			Utils.timeout(300, () => (self.hovered = true))
		},
		on_hover_lost: self => {
			if (!self.hovered) return

			self.hovered = false
			n.dismiss()
		},
		vexpand: false,
		child: Widget.Box({
			vertical: true,
			children: [
				Widget.Box({
					children: [
						NotificationIcon(n),
						Widget.Box({
							hexpand: true,
							vertical: true,
							children: [
								Widget.Box({
									children: [
										Widget.Label({
											className: 'title',
											xalign: 0,
											justification: 'left',
											hexpand: true,
											max_width_chars: 24,
											truncate: 'end',
											wrap: true,
											label: n.summary,
											use_markup: true,
										}),
										Widget.Button({
											className: 'close-button',
											vpack: 'start',
											child: Widget.Icon('window-close-symbolic'),
											on_clicked: n.close.bind(n),
										}),
									],
								}),
								Widget.Label({
									className: 'description',
									hexpand: true,
									use_markup: true,
									xalign: 0,
									justification: 'left',
									label: n.body,
									wrap: true,
								}),
							],
						}),
					],
				}),
				Widget.Box({
					className: 'actions',
					children: n.actions.map(({ id, label }) =>
						Widget.Button({
							className: 'action-button',
							on_clicked: () => n.invoke(id),
							hexpand: true,
							child: Widget.Label(label),
						})
					),
				}),
			],
		}),
	})
