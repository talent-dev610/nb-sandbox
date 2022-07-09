import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sbarsmartbrainapp/supps/constants.dart';

import 'constants.dart'; // limit text field length

class SbarFFDrop extends StatelessWidget {
  SbarFFDrop({
    required this.icon,
    required this.fieldLabel,
    required this.fieldValue,
    required this.onChanged,
    required this.items,
    this.validator,
    this.child,
  });

  final IconData icon;
  final String fieldLabel;
  final dynamic fieldValue;
  final Function onChanged;
  final List<Widget> items;
  final String? Function(dynamic)? validator;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[500]!,
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.grey[500],
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: DropdownButtonFormField(
                  hint: Text(
                    fieldLabel,
                    style: kFieldTitleStyle,
                  ),
                  value: fieldValue,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  onChanged: onChanged as void Function(dynamic)?,
                  validator: validator,
                  isExpanded: true,
                  items: items as List<DropdownMenuItem>?,
                  onTap: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                  },
                ),
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 0.0, left: 0.0),
        //   child: child,
        // ),
      ],
    );
  }
}

class SbarFFText extends StatelessWidget {
  SbarFFText(
      {required this.labelText,
      required this.hintText,
      this.helperStyle,
      this.helperText,
      this.prefixText,
      required this.icon,
      this.initialValue,
      this.textInputAction,
      this.inputFormat,
      this.controller,
      this.validator,
      this.filled,
      this.function,
      this.minLines,
      this.maxLines,
      this.onChanged,
      this.helperMaxLines,
      // this.autoCorrect,
      this.keyboard});

  final String labelText;
  final String hintText;
  final String? helperText;
  final TextStyle? helperStyle;
  final String? prefixText;
  final TextInputAction? textInputAction;
  final IconData icon;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormat;
  final TextEditingController? controller;
  final Function? onChanged;
  final String? Function(dynamic)? validator;
  final Function? function;
  final int? minLines;
  final int? maxLines;
  final int? helperMaxLines;
  final bool? filled;
  // final bool autoCorrect;
  final TextInputType? keyboard;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // field cannot have both initial value and validator at same time!
      initialValue: initialValue,
      onChanged: onChanged as void Function(String)?,
      validator: validator,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        helperMaxLines: helperMaxLines,
        prefixIcon: Icon(icon),
        prefixText: prefixText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      inputFormatters: inputFormat,
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      // autocorrect: autoCorrect,
      // update appbar title during form filling
      onEditingComplete: function as void Function()?,
      style: TextStyle(
        fontSize: 18.0,
      ),
    );
  }
}

class SbarFFLab extends StatelessWidget {
  SbarFFLab(
      {required this.labelText,
      required this.suffixText,
      required this.initialValue,
      required this.helperText,
      required this.helperTextStyle,
      this.prefixText,
      this.icon,
      this.textInputAction,
      this.inputFormat,
      this.controller,
      this.validator,
      this.function,
      this.minLines,
      this.maxLines,
      this.onChanged,
      this.helperMaxLines,
      // this.autoCorrect,
      this.keyboard});

  final String? labelText;
  final String? suffixText;
  final TextStyle helperTextStyle;
  final String? helperText;
  final String? prefixText;
  final TextInputAction? textInputAction;
  final IconData? icon;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormat;
  final TextEditingController? controller;
  final Function? onChanged;
  final String Function(dynamic)? validator;
  final Function? function;
  final int? minLines;
  final int? maxLines;
  final int? helperMaxLines;
  // final bool autoCorrect;
  final TextInputType? keyboard;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
        LengthLimitingTextInputFormatter(4)
      ],
      textInputAction: TextInputAction.next,
      initialValue: initialValue,
      onChanged: onChanged as void Function(String)?,
      decoration: InputDecoration(
        labelStyle: kFieldTitleStyle,
        labelText: labelText,
        suffix: Text(suffixText!),
        helperText: helperText,
        helperStyle: helperTextStyle,
        helperMaxLines: 2,
        prefixIcon: Icon(FontAwesomeIcons.vial),
      ),
      maxLines: 1,
    );
  }
}

class SbarFFVitals extends StatelessWidget {
  SbarFFVitals(
      {required this.labelText,
      required this.suffixText,
      required this.initialValue,
      required this.helperText,
      required this.helperTextStyle,
      required this.icon,
      this.prefixText,
      this.textInputAction,
      this.inputFormat,
      this.controller,
      this.validator,
      this.function,
      this.minLines,
      this.maxLines,
      this.onChanged,
      this.helperMaxLines,
      // this.autoCorrect,
      this.keyboard});

  final String? labelText;
  final String? suffixText;
  final TextStyle helperTextStyle;
  final String? helperText;
  final String? prefixText;
  final TextInputAction? textInputAction;
  final IconData icon;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormat;
  final TextEditingController? controller;
  final Function? onChanged;
  final String Function(dynamic)? validator;
  final Function? function;
  final int? minLines;
  final int? maxLines;
  final int? helperMaxLines;
  // final bool autoCorrect;
  final TextInputType? keyboard;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
        LengthLimitingTextInputFormatter(4)
      ],
      textInputAction: TextInputAction.next,
      initialValue: initialValue,
      onChanged: onChanged as void Function(String)?,
      decoration: InputDecoration(
        labelStyle: kFieldTitleStyle,
        labelText: labelText,
        suffix: Text(suffixText!),
        helperText: helperText,
        helperStyle: helperTextStyle,
        helperMaxLines: 2,
        prefixIcon: Icon(icon),
      ),
      maxLines: 1,
    );
  }
}

class SbarFFRadio extends StatelessWidget {
  SbarFFRadio({
    this.icon,
    required this.child,
  });

  final IconData? icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey[500],
            ),
            // SizedBox(
            //   width: 8.0,
            // ),
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class SbarFFGen extends StatelessWidget {
  SbarFFGen({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}
