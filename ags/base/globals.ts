import Mpris from 'gi://AstalMpris'
import Media from 'gi://AstalWp'
import { execAsync } from 'astal/process'

export const declareGlobals = () => {
  const mpris = Mpris.get_default()
  const media = Media.get_default()?.audio

  globalThis.audio = {
    setVolume(val: number) {
      if (typeof val !== 'number') return
      const speaker = media?.defaultSpeaker
      if (!speaker) return
      const vol = () => speaker.get_volume()
      if (val > 0) speaker.set_mute(false)
      speaker.set_volume(vol() + val)
      return vol()
    },
    toggleMute() {
      const speaker = media?.defaultSpeaker
      if (!speaker) return
      speaker.set_mute(!speaker.mute)
      // coerce boolean to number
      return (speaker.mute as unknown as number) + 0
    }
  }
  globalThis.brightness = {
    set(val: number) {
      if (typeof val !== 'number') return
      return execAsync(`brightnessctl set ${val > 0 ? `+${val * 100}%` : `${Math.abs(val) * 100}%-`} `)
    }
  }
  const playSignal = Object.freeze({
    0: 'pause',
    1: 'play',
    2: 'stop',
    3: 'previous',
    4: 'next',
  })
  globalThis.mpris = {
    run: (signal: keyof typeof playSignal) => {
      const players = mpris.get_players().filter((p) => p.length > 0 && p.playback_status !== Mpris.PlaybackStatus.STOPPED)
      console.log(players.map(p => ({
        name: p.get_bus_name(),
        len: p.get_length(),
        status: p.get_playback_status()
      })))
      const player = players[0]
      if (!player) throw new Error('no players available')

      switch (signal) {
        case 0:
          return players.map(p => p.pause());
        case 1:
          return player.play_pause()
        case 2:
          return players.filter(p => p.playback_status === Mpris.PlaybackStatus.PLAYING)[0].stop();
        case 3:
          return player.previous();
        case 4:
          return player.next();
      }
      // return player.get_playback_status() === Mpris.PlaybackStatus.PAUSED
    }
  }

}
