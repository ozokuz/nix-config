const date = Variable("", {
  poll: [1000, 'date "+%a, %d.%m.%y | %H:%M:%S"'],
});

export const Clock = () =>
  Widget.Button({
    className: "base",
    onClicked: () => console.log("Clock clicked"),
    child: Widget.Label({
      label: date.bind(),
    }),
  });
