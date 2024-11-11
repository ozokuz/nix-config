import { Bar } from "./bar/bar";
import { Widgets } from "./widgets";

App.config({
  windows: [Bar(0), ...Widgets],
  style: "./src/style.css",
});

Utils.timeout(100, () =>
  Utils.notify({
    summary: "Notification Popup Example",
    iconName: "help-about",
    body:
      "Lorem ipsum dolor sit amet, qui minim labore adipisicing " +
      "minim sint cillum sint consectetur cupidatat.",
    actions: {
      Cool: () => print("pressed Cool"),
    },
  })
);
