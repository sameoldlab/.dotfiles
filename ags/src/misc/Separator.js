import Gtk from 'gi://Gtk';
import { Widget } from '../imports.js';

export default ({ orientation = 'vertical', ...rest } = {}) => Widget.Separator({
    ...rest,
    orientation: Gtk.Orientation[orientation.toUpperCase()],
});
