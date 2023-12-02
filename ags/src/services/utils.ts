// https://github.com/pop-os/shell/blob/aafc9458a47a68c396933c637de00421f5198a2a/src/utils.ts#L120

import Gio from 'gi://Gio'

export type AsyncIPC = {
	child: any;
	stdout: any;
	stdin: any;
	cancellable: any;
};

export function async_process_ipc(argv: Array<string>): AsyncIPC | null {

	const { SubprocessLauncher, SubprocessFlags } = Gio;

	const launcher = new SubprocessLauncher({
			flags: SubprocessFlags.STDIN_PIPE | SubprocessFlags.STDOUT_PIPE,
	});

	let child: any;

	let cancellable = new Gio.Cancellable();

	try {
			child = launcher.spawnv(argv);
	} catch (why) {
			log.error(`failed to spawn ${argv}: ${why}`);
			return null;
	}

	let stdin = new Gio.DataOutputStream({
			base_stream: child.get_stdin_pipe(),
			close_base_stream: true,
	});

	let stdout = new Gio.DataInputStream({
			base_stream: child.get_stdout_pipe(),
			close_base_stream: true,
	});

	child.wait_async(null, (source: any, res: any) => {
			source.wait_finish(res);
			cancellable.cancel();
	});

	return { child, stdin, stdout, cancellable };
}

