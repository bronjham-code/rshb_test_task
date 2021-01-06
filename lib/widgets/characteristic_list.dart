import 'package:flutter/material.dart';
import 'package:rshb_test_task/models/characteristic.dart';
import 'package:rshb_test_task/widgets/dotted_separator.dart';

class CharacteristicList extends StatefulWidget {
  final List<ProductCharacteristic> characteristics;
  final int maxVisible;
  final bool isExpanded;

  const CharacteristicList(this.characteristics,
      {Key key, this.maxVisible = 5, this.isExpanded = false})
      : super(key: key);

  _CharacteristicList createState() => _CharacteristicList();
}

class _CharacteristicList extends State<CharacteristicList> {
  bool _state;

  @override
  void initState() {
    _state = widget.isExpanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.characteristics != null && widget.characteristics.isNotEmpty) {
      var countChar = (widget.characteristics.length <= widget.maxVisible)
          ? widget.characteristics.length
          : widget.maxVisible;
      List<Widget> visibleCharacteristics;
      for (var i = 0; i < countChar; i++) {
        if (visibleCharacteristics == null) {
          visibleCharacteristics = List<Widget>();
        }
        visibleCharacteristics.add(_characteristicTile(
            widget.characteristics[i].title, widget.characteristics[i].value));
      }
      List<Widget> inVisibleCharacteristics;
      if (widget.characteristics.length > visibleCharacteristics.length) {
        for (var i = visibleCharacteristics.length;
            i < widget.characteristics.length;
            i++) {
          if (inVisibleCharacteristics == null) {
            inVisibleCharacteristics = List<Widget>();
          }
          inVisibleCharacteristics.add(_characteristicTile(
              widget.characteristics[i].title,
              widget.characteristics[i].value));
        }
      }
      return Column(children: <Widget>[
        Column(children: visibleCharacteristics),
        inVisibleCharacteristics != null
            ? Visibility(
                visible: _state,
                child: Column(children: inVisibleCharacteristics))
            : Container(),
        inVisibleCharacteristics != null
            ? FlatButton(
                padding: EdgeInsets.all(0),
                minWidth: double.infinity,
                onPressed: () => setState(() => _state = _state ? false : true),
                child: Row(
                  children: [
                    Text(
                      _state ? 'Скрыть характеристики' : 'Все характеристики',
                      style: TextStyle(
                          color: const Color(0xFF42AB44),
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      _state
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_right,
                      color: const Color(0xFF42AB44),
                    )
                  ],
                ))
            : Container()
      ]);
    }
    return Container();
  }

  Widget _characteristicTile(String title, String value) => Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                title,
                style: TextStyle(color: const Color(0xFF969696)),
              )),
          Expanded(
              child: Container(
                  height: 8,
                  alignment: Alignment.bottomCenter,
                  child: DottedSeparator(color: const Color(0xFF969696)))),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                value,
              )),
        ],
      ));
}
