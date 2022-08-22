// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme_provider.dart';

class FormTile extends StatefulWidget {
  Icon? prefixIcon;
  String labelText;
  String hintText;
  int? minLines;
  var validator;
  FormTile({
    Key? key,
    this.prefixIcon,
    required this.labelText,
    required this.hintText,
    this.minLines = 1,
    this.validator,
  }) : super(key: key);

  @override
  State<FormTile> createState() => _FormTileState();
}

class _FormTileState extends State<FormTile> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var isWide = deviceSize.width > 640;
    return Container(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) => Text(
                    widget.labelText,
                    textScaleFactor: 1.2,
                    style: themeProvider.appTheme.textTheme.headline6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) => TextFormField(
                    validator: widget.validator,
                    minLines: widget.minLines,
                    maxLines: widget.minLines,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        prefixIconConstraints: widget.prefixIcon != null
                            ? BoxConstraints(maxWidth: 50, minWidth: 50)
                            : BoxConstraints(maxWidth: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(width: 40)),
                        prefixIcon: widget.prefixIcon ?? Container(),
                        hintText: widget.hintText,
                        hintStyle: themeProvider.appTheme.textTheme.subtitle1)),
              ),
            )
          ]),
    );
  }
}
