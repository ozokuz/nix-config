import GObject, { register, property } from "astal/gobject";
import { readFile } from "astal/file";
import { interval } from "astal/time";
import { fetch } from "../lib/fetch";

@register()
export class Weather extends GObject.Object {
  @property(String)
  declare short: string;

  @property(String)
  declare long: string;

  #location = readFile("/home/ozoku/.local/weather.txt");

  constructor() {
    super();

    interval(60 * 60 * 1000, () => this.#update());
  }

  #url(format: number) {
    return `https://wttr.in/${this.#location.trim()}?format=${format}`;
  }

  async #update() {
    const short = await fetch(this.#url(1))
      .then((r) => r.text())
      .catch(console.error);
    const long = await fetch(this.#url(4))
      .then((r) => r.text())
      .catch(console.error);

    this.short = short?.trim() ?? "☁️ ❌";
    this.long = long?.trim() ?? "Error fetching weather";
  }
}
