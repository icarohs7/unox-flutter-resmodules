import 'package:flutter/material.dart';

class NumberStepper extends StatelessWidget {
  const NumberStepper(
    this.number, {
    required this.onChange,
    this.iconColor,
    this.increaseEnabled = true,
    this.decreaseEnabled = true,
    this.decoration,
  });

  final int number;
  final void Function(int number, NumberStepperEvent event) onChange;
  final Color? iconColor;
  final bool increaseEnabled;
  final bool decreaseEnabled;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.remove),
            color: iconColor ?? Theme.of(context).accentColor,
            onPressed: decreaseEnabled ? () => onChange(number, NumberStepperEvent.decrease) : null,
          ),
          Text('$number'),
          IconButton(
            icon: Icon(Icons.add),
            color: iconColor ?? Theme.of(context).accentColor,
            onPressed: increaseEnabled ? () => onChange(number, NumberStepperEvent.increase) : null,
          ),
        ],
      ),
    );
  }
}

enum NumberStepperEvent {
  increase,
  decrease,
}
