import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask; // = '0-0-0-0-0-0';
  MaskedTextInputFormatter({required this.mask});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 0) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length && mask[newValue.text.length - 1] == '-') {
          return TextEditingValue(
            text: '${oldValue.text}-${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}
