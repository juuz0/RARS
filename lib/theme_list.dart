import 'package:flutter/material.dart';
import 'theme_colors_available.dart';
import 'extensions.dart';

class ThemeList extends StatefulWidget {
  final Function colorchange;
  const ThemeList(this.colorchange, {Key? key}) : super(key: key);

  @override
  _ThemeListState createState() => _ThemeListState();
}

class _ThemeListState extends State<ThemeList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      // margin: const EdgeInsets.symmetric(vertical: 20.0),
      margin: const EdgeInsets.only(top: 15, bottom: 15, left: 0),
      height: 25.0,
      width: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var colors in colorsAvailable)
            Container(
              color: Colors.transparent,
              width: 20.0,
              margin: const EdgeInsets.only(left: 5, right: 5),
              child: RawMaterialButton(
                onPressed: () {
                  widget.colorchange(colors.colorID);
                },
                elevation: 2.0,
                fillColor: colors.colorID.toColor(),
                shape: const CircleBorder(),
              ),
            )
        ],
      ),
    );
  }
}
