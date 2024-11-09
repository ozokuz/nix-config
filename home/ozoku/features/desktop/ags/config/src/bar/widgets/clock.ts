const date = Variable("", {
  poll: [1000, 'date "+%a, %d.%m.%y | %H:%M:%S"'],
});

export const Clock = () =>
  Widget.Label({
    label: date.bind(),
  });
