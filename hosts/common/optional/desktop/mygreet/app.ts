import { App } from "astal/gtk3"
import style from "./style.scss"
import LoginScreen from "./widget/LoginScreen"

App.start({
    css: style,
    main() {
        App.get_monitors().map(LoginScreen)
    },
})
