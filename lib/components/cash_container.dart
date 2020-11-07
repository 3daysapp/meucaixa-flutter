import 'package:flutter/material.dart';
import 'package:meu_caixa_flutter/components/plus_sub_button.dart';

///
///
///
class CashContainer extends StatefulWidget {
  final String label;
  final int initialValue;
  final Function(int) onChanged;

  ///
  ///
  ///
  CashContainer({
    Key key,
    @required this.label,
    this.initialValue = 0,
    @required this.onChanged,
  }) : super(key: key);

  ///
  ///
  ///
  @override
  _CashContainerState createState() => _CashContainerState();
}

///
///
///
class _CashContainerState extends State<CashContainer> {
  final TextEditingController _controller = TextEditingController();

  ///
  ///
  ///
  int get _getInt => int.tryParse(_controller.text);

  ///
  ///
  ///
  set _getInt(int value) => _controller.text = value.toString();

  ///
  ///
  ///
  @override
  void initState() {
    super.initState();
    _getInt = widget.initialValue;
    _controller.addListener(() => widget.onChanged(_getInt));
  }

  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.label,
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                PlusSubButton(
                  type: PlusSubButtonType.SUB,
                  onPressed: () => _getInt > 0 ? _getInt-- : null,
                  onLongPress: () => _getInt = 0,
                ),
                SizedBox(
                  width: 60,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _controller,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                PlusSubButton(
                  type: PlusSubButtonType.PLUS,
                  onPressed: () => _getInt < 99 ? _getInt++ : null,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  ///
  ///
  ///
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
