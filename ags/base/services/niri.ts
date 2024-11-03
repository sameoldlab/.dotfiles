/*
 * Copyright (C) 2024 Winter <a2405392127a@gmail.com>
 *
 * SPDX-License-Identifier: MIT
 */

import { GLib, Gio } from "astal";
import GObject, { register, signal } from "astal/gobject";

@register({ GTypeName: "Niri" })
export default class Niri extends GObject.Object {
  static instance: Niri;
  static get_default() {
    if (!this.instance) this.instance = new Niri();
    return this.instance;
  }

  private _connection = () => {
    const socketPath = GLib.getenv("NIRI_SOCKET");
    if (!socketPath) console.error("Niri not running");

    const client = new Gio.SocketClient();
    return client.connect(
      new Gio.UnixSocketAddress({ path: socketPath }),
      null,
    );
  };

  private _watchSocket = (
    connection: Gio.SocketConnection,
    inputStream: Gio.DataInputStream,
  ) => {
    const outputStream = Gio.DataOutputStream.new(connection.output_stream);

    outputStream.put_string('"EventStream"\n', null);
    outputStream.flush(null);

    inputStream.read_line_async(0, null, (stream, result) => {
      const [line] = inputStream.read_line_finish_utf8(result);
      this.emit("event", JSON.parse(line));
      this._watchSocket(connection, stream);
    });
  };

  readonly message = (msg: Object) => {
    const connection = this._connection();

    const inputStream = Gio.DataInputStream.new(connection.input_stream);
    const outputStream = Gio.DataOutputStream.new(connection.output_stream);

    outputStream.put_string(`${JSON.stringify(msg)}\n`, null);
    outputStream.flush(null);

    const [line] = inputStream.read_line_utf8(null);
    return JSON.parse(line);
  };

  @signal(Object)
  declare event: (event: Object) => void;

  constructor() {
    super();

    const connection = this._connection();

    this._watchSocket(
      connection,
      new Gio.DataInputStream({ baseStream: connection.get_input_stream() }),
    );
  }
}
