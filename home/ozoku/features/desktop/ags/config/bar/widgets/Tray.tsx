import { bind, Gio, Variable } from "astal";
import { App, Gtk } from "astal/gtk4";
import Tray from "gi://AstalTray";
import style from "./Tray.scss";

function createMenu(
  menuModel: Gio.MenuModel,
  actionGroup: Gio.ActionGroup | null
): Gtk.PopoverMenu {
  const menu = Gtk.PopoverMenu.new_from_model(menuModel);
  menu.insert_action_group("dbusmenu", actionGroup);

  return menu;
}

const bad = ["gammastep", "spotify-client", "Bitwarden"];
function filterTrayIcons(item: Tray.TrayItem) {
  return !bad.includes(
    item.id === "chrome_status_icon_1" ? item.tooltipMarkup : item.id
  );
}

App.apply_css(style);

export default function SysTray() {
  const tray = Tray.get_default();

  return (
    <box cssClasses={["tray"]}>
      {bind(tray, "items").as((items) =>
        items.filter(filterTrayIcons).map((item) => {
          const pop = Variable.derive(
            [bind(item, "menuModel"), bind(item, "actionGroup")],
            (menuModel, actionGroup) => createMenu(menuModel, actionGroup)
          );
          return (
            <menubutton
              tooltipMarkup={bind(item, "tooltipMarkup")}
              popover={pop()}
              onButtonReleased={(self, event) => {
                const RIGHT = 3;
                if (event.get_button() === RIGHT) {
                  const [_, [x, y]] = event.get_axes();
                  item.activate(x, y);
                }
              }}
            >
              <image gicon={bind(item, "gicon")} />
            </menubutton>
          );
        })
      )}
    </box>
  );
}
