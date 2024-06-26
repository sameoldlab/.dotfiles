import Gtk from 'gi://Gtk?version=3.0'
import Gio from 'gi://Gio'
import GLib from 'gi://GLib'

type Args<Out = void, Err = void> = {
	cmd: string | string[]
	out?: (stdout: string) => Out
	err?: (stderr: string) => Err
}

function proc(arg: Args | string | string[]) {
	let cmd = Array.isArray(arg) || typeof arg === 'string' ? arg : arg.cmd

	if (typeof cmd === 'string') {
		const [, argv] = GLib.shell_parse_argv(cmd)
		cmd = argv
	}

	return Gio.Subprocess.new(
		cmd,
		Gio.SubprocessFlags.STDOUT_PIPE |
			Gio.SubprocessFlags.STDERR_PIPE |
			Gio.SubprocessFlags.STDIN_PIPE
	)
}

function readStream(
	stream: Gio.DataInputStream,
	callback: (out: string) => void
) {
	stream.read_line_async(GLib.PRIORITY_DEFAULT, null, (_, res) => {
		const output = stream?.read_line_finish_utf8(res)[0]
		if (typeof output === 'string') {
			callback(output.trim())
			readStream(stream, callback)
		}
	})
}

export function subprocess(
	argsOrCmd: (Args & { bind?: Gtk.Widget }) | string | string[],
	out: (stdout: string) => void = print,
	err: (stderr: string) => void = err => console.error(Error(err)),
	bind?: Gtk.Widget
) {
	const p = proc(argsOrCmd)

	let cancellable = new Gio.Cancellable()
	let child: Gio.Subprocess

	try {
		child = new Gio.SubprocessLauncher({
			flags: Gio.SubprocessFlags.STDIN_PIPE | Gio.SubprocessFlags.STDOUT_PIPE,
		}).spawnv(['pop-launcher'])
	} catch (error) {
		throw Error(`spawn failed: ${error}`)
	}

	let stdin = new Gio.DataOutputStream({
		base_stream: p.get_stdin_pipe(),
		close_base_stream: true,
	})

	let stdout = new Gio.DataInputStream({
		base_stream: child.get_stdout_pipe(),
		close_base_stream: true,
	})

	const stderr = new Gio.DataInputStream({
		base_stream: p.get_stderr_pipe(),
		close_base_stream: true,
	})

	if (bind) bind.connect('destroy', () => p.force_exit())

	const onErr =
		Array.isArray(argsOrCmd) || typeof argsOrCmd === 'string'
			? err
			: argsOrCmd.err

	const onOut =
		Array.isArray(argsOrCmd) || typeof argsOrCmd === 'string'
			? out
			: argsOrCmd.out

	/*  */
	child.wait_async(null, (source: any, res: any) => {
		source.wait_finish(res)
		cancellable.cancel()
	})

	// return { child, stdin, stdout, cancellable }

	readStream(stdout, onOut ?? out)
	readStream(stderr, onErr ?? err)
	return Object.assign(p, {
		write(str: string): void {
			stdin.write_all(new TextEncoder().encode(str), null)
		},
		writeAsync(str: string): Promise<void> {
			return new Promise((resolve, reject) => {
				stdin.write_all_async(
					new TextEncoder().encode(str),
					GLib.PRIORITY_DEFAULT,
					null,
					(stdin, res) => {
						stdin.write_all_finish(res)[0] ? resolve() : reject()
					}
				)
			})
		},
	})
}
