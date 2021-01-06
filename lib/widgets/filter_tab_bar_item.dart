import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterTabBarItem extends StatefulWidget {
  final bool initState;
  final String title;
  final String assetFilePath;
  final Color selectedColor;
  final Color unSelectedIconColor;
  final Color unSelectedTitleColor;
  final Color unSelectedBorderColor;

  final void Function(bool) onPressed;

  FilterTabBarItem(this.title, this.assetFilePath,
      {Key key,
      this.initState = false,
      this.selectedColor = const Color(0xFF42AB44),
      this.unSelectedIconColor = const Color(0xFF1C1C1C),
      this.unSelectedTitleColor = const Color(0xFF969696),
      this.unSelectedBorderColor = const Color(0xFFE0E0E0),
      this.onPressed})
      : super(key: key);
  _FilterTabBarItemState createState() => _FilterTabBarItemState();
}

class _FilterTabBarItemState extends State<FilterTabBarItem> {
  bool _state;

  @override
  void initState() {
    _state = widget.initState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        height: 80,
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border:
                        Border.all(width: 1.5, color: const Color(0xFFE0E0E0))),
                child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: SvgPicture.asset(
                      widget.assetFilePath,
                      color: _state
                          ? widget.selectedColor
                          : widget.unSelectedIconColor,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_state) {
                          _state = false;
                        } else {
                          _state = true;
                        }
                      });
                      if (widget.onPressed != null) widget.onPressed(_state);
                    })),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  color:
                      _state ? widget.selectedColor : const Color(0xFF969696)),
            )
          ],
        ));
  }
}
