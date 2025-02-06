// TODO: use a proper weather api instead of wttr.in
class WeatherService extends Service {
  static {
    Service.register(
      this,
      {},
      { short: ["string", "r"], long: ["string", "r"] }
    );
  }

  #location = Utils.readFile("/home/ozoku/.local/weather.txt").trim();

  #short = "";
  #long = "";

  get short() {
    return this.#short;
  }

  get long() {
    return this.#long;
  }

  constructor() {
    super();

    Utils.interval(60 * 60 * 1000, () => this.#update());
  }

  #url(format: number) {
    return `https://wttr.in/${this.#location}?format=${format}`;
  }

  async #update() {
    const short = Utils.fetch(this.#url(1))
      .then((r) => r.text())
      .catch(console.error);
    const long = Utils.fetch(this.#url(4))
      .then((r) => r.text())
      .catch(console.error);

    this.#short = (await short)?.trim() ?? "☁️ ❌";
    this.#long = (await long)?.trim() ?? "Error fetching weather";

    this.changed("short");
    this.changed("long");
  }
}

const service = new WeatherService();

export default service;
