import Service from 'resource:///com/github/Aylur/ags/service.js'
import GLib from 'gi://GLib'
import Gio from 'gi://Gio'

import {async_process_ipc, LauncherService} from './launcherIPC.js'
import type {JsonIPC} from './launcherIPC.js'

interface SearchOption {
	result: JsonIPC.SearchResult;
	menu: typeof Widget.Menu;
}

class Launcher {
	service: null | LauncherService = null
	cancel: () => void = () => {};
	search: (search: string) => void = () => {};
	
	constructor() {
		// super()
		this.cancel = () => {
			this.stop_services();
		};

		this.search = (pat: string) => {
			if (this.service !== null) {
					this.service.query(pat);
			}
		}
	}
	
	on_response(response: JsonIPC.Response) {
		if('Close' === response) {
			// this.close()
		} else if('Update' in response) {
			console.log('response: ' + response)
			console.log(response.Update)
		}
	}

	start_services() {
		if (this.service === null) {
			console.log('starting pop-launcher service');
			const ipc = async_process_ipc(['pop-launcher']);
			this.service = ipc ? new LauncherService(ipc, (resp) => this.on_response(resp)) : null;
			print('l31: service connected')
		}
		else print('l33: service already active')
	}

	stop_services() {
		if (this.service !== null) {
				console.log(`stopping pop-launcher services`);
				this.service.exit();
				this.service = null;
		}
}
	
}

/* const res = new Launcher()
res.start_services()
res.search('reboot') */
// res.cancel()

class PopLauncher extends Service {
	constructor() {
		super()

	}

	static {
	/**
	  the class itself
		an object defining the signals
		an object defining its properties
	 */
		Service.register(
			this,
			{

			},
			{

			}
		)
	}


	
}


const service = new PopLauncher()

export default service