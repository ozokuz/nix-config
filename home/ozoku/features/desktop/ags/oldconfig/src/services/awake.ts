class AwakeService extends Service {
  static {
    Service.register(this, {}, { state: ["boolean", "r"] });
  }

  #state = false;

  get state() {
    return this.#state;
  }

  set state(value) {
    this.#state = value;

    Utils.execAsync(`awakectl set ${value ? "keep-awake" : "allow-sleep"}`);
  }

  toggle() {
    this.state = !this.state;
  }

  constructor() {
    super();

    Utils.exec("awakectl get");

    Utils.monitorFile("/tmp/awake_status", () => this.#onChange());

    this.#onChange();
  }

  #onChange() {
    this.#state = Utils.exec("awakectl get").startsWith("keep-awake");

    this.changed("state");
  }
}

const service = new AwakeService();

export default service;
