const Bar = (monitor: number) =>
  Widget.Window({
    name: `bar-${monitor}`,
    anchor: ["top", "left", "right"],
    margins: [8, 0, 0, 0],
    exclusivity: "exclusive",
    child: Widget.Label("hello"),
  });

const cssFile = "./style.css";

App.config({
  windows: [Bar(0)],
  style: cssFile,
});

Utils.monitorFile(cssFile, () => {
  App.resetCss();
  App.applyCss(cssFile);
});
