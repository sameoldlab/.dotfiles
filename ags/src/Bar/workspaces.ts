import { Widget, Utils, App } from '../imports.js'
import { Hyprland } from '../services/index.js'

const Workspaces = () =>
	Widget.Box({
		className: 'workspaces',
		connections: [
			[
				Hyprland.active.workspace,
				self => {
					// generate an array [1..10] then make buttons from the index
					const arr = Array.from({ length: 10 }, (_, i) => i + 1)
					self.children = arr.map(i =>
						Widget.Button({
							onClicked: () =>
								Utils.execAsync(`hyprctl dispatch workspace ${i}`),
							child: Widget.Label(`${i}`),
							className: Hyprland.active.workspace.id === i ? 'focused' : '',
						})
					)
				},
			],
		],
	})

const WORKSPACE_SIDE_PAD = 0.546 // rem
const NUM_OF_WORKSPACES = 10
let lastWorkspace = 0

const activeWorkspaceIndicator = Widget.Box({
	css: `
        padding: 0rem ${WORKSPACE_SIDE_PAD}rem;
    `,
	children: [
		Widget.Box({
			vpack: 'center',
			hpack: 'start',
			className: 'focused',
			connections: [
				[
					Hyprland.active.workspace,
					box => {
						const ws = Hyprland.active.workspace.id
						box.setCss(`
                        margin-left: ${1.774 * (ws - 1) + 0.068}rem;
                    `)
						lastWorkspace = ws
					},
				],
			],
			children: [
				Widget.Label({
					vpack: 'center',
					className: 'focused',
					label: `•`,
				}),
			],
		}),
	],
})

const ModuleWorkspaces = () =>
	Widget.EventBox({
		onScrollUp: () => Utils.execAsync('hyprctl dispatch workspace -1'),
		onScrollDown: () => Utils.execAsync('hyprctl dispatch workspace -1'),
		// onMiddleClickRelease: () => App.toggleWindow('overview'),
		// onSecondaryClickRelease: () => App.toggleWindow('osk'),
		child: Widget.Box({
			homogeneous: true,
			className: 'workspaces',
			children: [
				Widget.Overlay({
					passThrough: true,
					child: Widget.Box({
						homogeneous: true,
						className: 'bar-group-center',
						children: [
							Widget.Box({
								className: 'bar-group-standalone bar-group-pad',
							}),
						],
					}),
					overlays: [
						Widget.Overlay({
							setup: self => {
								Utils.timeout(1, () => {
									self.set_overlay_pass_through(self.get_children()[1], true)
								})
							},
							child: Widget.Box({
								hpack: 'center',
								css: `padding: 0rem ${WORKSPACE_SIDE_PAD}rem;`,
								// homogeneous: true,
								children: Array.from(
									{ length: NUM_OF_WORKSPACES },
									(_, i) => i + 1
								).map(i =>
									Widget.Button({
										onPrimaryClick: () =>
											Utils.execAsync(`hyprctl dispatch workspace ${i}`).catch(
												print
											),
										child: Widget.Label({
											vpack: 'center',
											label: `${i}`,
											className: 'bar-ws txt',
										}),
									})
								),
								connections: [
									[
										Hyprland,
										box => {
											console.log('update')
											const kids = box.children
											kids.forEach((child, i) => {
												child.child.toggleClassName('bar-ws-occupied', false)
												child.child.toggleClassName(
													'bar-ws-occupied-left',
													false
												)
												child.child.toggleClassName(
													'bar-ws-occupied-right',
													false
												)
												child.child.toggleClassName(
													'bar-ws-occupied-left-right',
													false
												)
											})
											const occupied = Array.from(
												{ length: NUM_OF_WORKSPACES },
												(_, i) => Hyprland.getWorkspace(i + 1)?.windows > 0
											)
											for (let i = 0; i < occupied.length; i++) {
												if (!occupied[i]) continue
												const child = kids[i]
												child.child.toggleClassName(
													`bar-ws-occupied${!occupied[i - 1] ? '-left' : ''}${
														!occupied[i + 1] ? '-right' : ''
													}`,
													true
												)
											}
										},
										'notify::workspaces',
									],
								],
							}),
							overlays: [activeWorkspaceIndicator],
						}),
					],
				}),
			],
		}),
	})

export default Workspaces
