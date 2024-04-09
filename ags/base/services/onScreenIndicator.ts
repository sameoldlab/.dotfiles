import icons from '../utils/icons.js';
import { Audio } from './index.js';
import Brightness from './brightness.js';

const getAudioTypeIcon = (icon) => {
	const subs = {
		'audio-headset-bluetooth'	: icons.audio.type.headset,
		'audio-card-analog-usb'		: icons.audio.type.speaker,
		'audio-card-analog-pci'		: icons.audio.type.card,
	}
 
	return subs[icon] ? subs[icon] : null
}	

class Indicator extends Service {
    static {
        Service.register(
					this,
					 {
            'popup': ['double', 'string'],
					 },
				);
    }

    #delay = 1500;
    #count = 0;

    popup(value, icon) {
        this.emit('popup', value, icon);
        this.#count++;
        Utils.timeout(this.#delay, () => {
            this.#count--;

            if (this.#count === 0)
                this.emit('popup', -1, icon);
        });
    }


    speaker() {
			if(!Audio.speaker) throw Error("Audio.speaker does not exist from Indicator service line:43")
				
        this.popup(
					Audio.speaker.volume,
          getAudioTypeIcon(Audio.speaker.icon_name),
        );
    }


    display() {
        // brightness is async, so lets wait a bit
        Utils.timeout(10, () => this.popup(
            Brightness.screen_value,
            icons.brightness.screen));
    }

/*     kbd() {
        // brightness is async, so lets wait a bit
        Utils.timeout(10, () => this.popup(
            (Brightness.kbd * 33 + 1) / 100,
            icons.brightness.keyboard));
    } */

    connect(event = 'popup', callback) {
        return super.connect(event, callback);
    }

}

export default new Indicator();
