import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavoriteButton extends StatefulWidget {
  final bool state;
  final EdgeInsetsGeometry margin;
  final BoxBorder border;
  final Color selectedColor;
  final Color unSelectedColor;
  final void Function() onPressed;

  final bool isSmall;

  FavoriteButton(
      {Key key,
      this.state,
      this.margin,
      this.border,
      this.selectedColor = const Color(0xFF42AB44),
      this.unSelectedColor = const Color(0xFF1C1C1C),
      this.onPressed,
      this.isSmall = true})
      : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: widget.margin,
        height: widget.isSmall ? 32 : 40,
        width: widget.isSmall ? 32 : 40,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            border: widget.border),
        child: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: SvgPicture.asset(
              widget.state
                  ? 'assets/icons/favorite_filled_icon.svg'
                  : 'assets/icons/favorite_icon.svg',
              width: widget.isSmall ? null : 18,
              height: widget.isSmall ? null : 18,
              color:
                  widget.state ? widget.selectedColor : widget.unSelectedColor,
            ),
            onPressed: widget.onPressed));
  }
}
