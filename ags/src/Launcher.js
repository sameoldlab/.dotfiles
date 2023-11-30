import {Widget} from 'resource:///com/github/Aylur/ags/widget.js'
import App from 'resource:///com/github/Aylur/ags/app.js'
import Applications from 'resource:///com/github/Aylur/ags/service/applications.js'
// import Separator from './misc/Separator.js';
import PopupWindow from './misc/PopupWindow.js';
// import icons from './icons.js';

const WINDOW_NAME = 'applauncher'
const AppItem = app => Widget.Button({
    className: 'app',
    onClicked: () => {
        App.closeWindow(WINDOW_NAME);
        app.launch();
    },
    child: Widget.Box({
        children: [
            Widget.Icon({
                icon: app.iconName,
                size: 48,
            }),
            Widget.Box({
                vertical: true,
                children: [
                    Widget.Label({
                        class_name: 'title',
                        label: app.name,
                        xalign: 0,
                        valign: 'center',
                        ellipsize: 3,
                    }),
                    Widget.Label({
                        class_name: 'description',
                        label: app.description || '',
                        wrap: true,
                        xalign: 0,
                        justification: 'left',
                        valign: 'center',
                    }),
                ],
            }),
        ],

    }),
});

const Applauncher = () => {
    const list = Widget.Box({ vertical: true });

    const placeholder = Widget.Label({
        label: " Couldn't find a match",
        className: 'placeholder',
    });

    const entry = Widget.Entry({
        hexpand: true,
        text: '-',
        placeholderText: 'Search',
        on_accept: ({ text }) => {
            const list = Applications.query(text);
            if (list[0]) {
                App.toggleWindow(WINDOW_NAME);
                list[0].launch();
            }
        },
        on_change: ({ text }) => {
            list.children = Applications.query(text).map(app => [
                AppItem(app),
            ]).flat();
            // list.add(Separator());
            list.show_all();

            placeholder.visible = list.children.length === 1;
        },
    });

    return Widget.Box({
        className: 'applauncher',
        properties: [['list', list]],
        vertical: true,
        children: [
            Widget.Box({
                className: 'header',
                children: [
                    // Widget.Icon(icons.apps.search),
                    entry,
                ],
            }),
            Widget.Scrollable({
                hscroll: 'never',
                child: Widget.Box({
                    vertical: true,
                    children: [list, placeholder],
                }),
            }),
        ],
        connections: [[App, (_, name, visible) => {
            if (name !== WINDOW_NAME)
                return;

            entry.set_text('');
            if (visible)
                entry.grab_focus();
        }]],
    });
};

/* export default () => PopupWindow({
    name: WINDOW_NAME,
    content: Applauncher(),
});
 */
export default Widget.Window({
	name: WINDOW_NAME,
	popup: true,
	visible: false,
	focusable: true,
	child: Applauncher(),
})
