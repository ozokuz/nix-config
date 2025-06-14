import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { Variable } from "astal";
import { Entry } from "astal/gtk3/widget";
import AstalGreet from "gi://AstalGreet";

const clock = Variable("").poll(1000, 'date "+%H:%M"');

export default function LoginScreen(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT, BOTTOM } = Astal.WindowAnchor;

  function onEnter(self: Entry) {
    AstalGreet.login("ozoku", self.text, "", (_, res) => {
      try {
        AstalGreet.login_finish(res);
      } catch (error) {
        printerr(error);
      }
    });
    App.quit(0);
  }

  return (
    <window
      className="LoginScreen"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.ON_DEMAND}
      layer={Astal.Layer.TOP}
      anchor={TOP | LEFT | RIGHT | BOTTOM}
      application={App}
      widthRequest={gdkmonitor.get_workarea().width}
      heightRequest={gdkmonitor.get_workarea().height}
    >
      <box className="Background">
        <box orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER}>
          <box heightRequest={40} />
          <label label={clock()} className="Clock" />
          <box heightRequest={300} />
          <label className="Username" label="ozoku" halign={Gtk.Align.CENTER} />
          <box
            orientation={Gtk.Orientation.HORIZONTAL}
            halign={Gtk.Align.CENTER}
          >
            <box hexpand />
            <entry
              text={password()}
              onChanged={(self) => password.set(self.text)}
              onActivate={onEnter}
              visibility={false}
            />
            <box hexpand />
          </box>
          <box heightRequest={370} />
          <box className="PowerButtons" hexpand halign={Gtk.Align.CENTER}>
            <button onClick={() => App.quit(0)}>
              <label label="@" />
            </button>
            <button>
              <label label="@" />
            </button>
            <button>
              <label label="@" />
            </button>
          </box>
        </box>
      </box>
    </window>
  );
}
