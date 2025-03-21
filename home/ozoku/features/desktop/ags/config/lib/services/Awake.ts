import { exec } from "astal";
import { monitorFile } from "astal/file";
import GObject, { register, property } from "astal/gobject";

@register()
export class Awake extends GObject.Object {
  #state = false;

  @property(Boolean)
  get state() {
    return this.#state;
  }

  toggle() {
    exec("awakectl toggle");
  }

  constructor() {
    super();

    exec("awakectl get");

    monitorFile("/tmp/awake_status", () => this.#onChange());

    this.#onChange();
  }

  #onChange() {
    this.#state = exec("awakectl get").startsWith("keep-awake");

    this.notify("state");
  }
}
