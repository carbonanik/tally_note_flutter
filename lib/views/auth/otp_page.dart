import 'package:flutter/material.dart';

class CustomKeyboardScreen extends StatefulWidget {
  const CustomKeyboardScreen({super.key});

  @override
  State<CustomKeyboardScreen> createState() => _CustomKeyboardScreenState();
}

class _CustomKeyboardScreenState extends State<CustomKeyboardScreen> {
  String code = "";

  // String code = "";
  final List<List<dynamic>> keys = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
    ['00', '0', const Icon(Icons.keyboard_backspace)],
  ];

  onNumberPress(val) {
    if (code.length >= 4) {
      return;
    }
    setState(() {
      code += val;
    });
  }

  onBackspacePress(val) {
    setState(() {
      code = code.substring(0, code.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            _renderCode(),
            const Spacer(),
            // _renderText(),
            _renderKeyBoard(),
          ],
        ),
      ),
    );
  }

  Widget _renderKeyBoard() {
    return Column(
      children: keys
          .map(
            (x) => Row(
              children: x
                  .map(
                    (y) => Expanded(
                      child: KeyboardKey(
                        label: y,
                        value: y,
                        onTap: y is Widget ? onBackspacePress : onNumberPress,
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  _renderCode() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [for (var i = 0; i < 4; i++) _renderCodeCell(i)]);
  }

  _renderCodeCell(int index) {
    final number = code.length > index ? code[index] : '';
    final isLast = index == code.length - 1;

    final isEmpty = number.isEmpty;
    final isCurrent = index == code.length;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 60,
          width: 60,
          color: isEmpty
              ? isCurrent
                  ? Colors.blueGrey.shade800.withOpacity(.3)
                  : Colors.grey.shade800.withOpacity(.5)
              : isLast
                  ? Colors.blueGrey.shade800.withOpacity(.5)
                  : Colors.grey.shade900,
          child: Center(
            child: Text(
              number,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
      ),
    );
  }
}

class KeyboardKey extends StatefulWidget {
  const KeyboardKey({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final dynamic label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;

  @override
  State<KeyboardKey> createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends State<KeyboardKey> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap(widget.value);
      },
      child: AspectRatio(
        aspectRatio: 2,
        child: Center(
          child: _renderLabel(),
        ),
      ),
    );
  }

  Widget _renderLabel() {
    if (widget.label is String) {
      return Text(
        widget.label,
        style: Theme.of(context).textTheme.headlineSmall,
      );
    } else if (widget.label is Widget) {
      return widget.label;
    } else {
      return Container();
    }
  }
}
