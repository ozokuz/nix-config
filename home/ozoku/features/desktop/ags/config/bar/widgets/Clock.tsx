import { Variable } from "astal";

const clock = Variable("").poll(100, 'date "+%a, %d.%m.%y | %H:%M:%S"');

export default function Clock() {
  return (
    <box>
      <label label={clock()} />
    </box>
  );
}
