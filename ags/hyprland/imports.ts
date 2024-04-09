import Service from 'resource:///com/github/Aylur/ags/service.js'
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js'
import Widget  from 'resource:///com/github/Aylur/ags/widget.js'
import Variable  from 'resource:///com/github/Aylur/ags/variable.js'
import App  from 'resource:///com/github/Aylur/ags/app.js'

const resource = (file) => `resource:///com/github/Aylur/ags/${file}.js`
const require = async (file) => (await import(resource(file))).default

export {Widget, Service, Variable,	Utils, App}