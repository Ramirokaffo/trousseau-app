import 'package:flutter/services.dart';

/// Format textfield in Cameroon Format
///
/// like this example of phone number 699 04 04 04.
class CameroonPhoneNumberFormatter extends TextInputFormatter {
  static const _separator = ' ';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newString = newValue.text;

    // Reduit de -1 pour avoir la bonne longeur de tableau
    int lenght = newValue.selection.baseOffset - 1;
    int offsetLenght = newValue.selection.extentOffset;

    if (newString.isEmpty) {
      // Return the new value without formatting
      return newValue;
    }

    final buffer = StringBuffer();

    // Ajoute le separateur si le texte saissis a la
    // longeur souhaité
    for (var i = 0; i < newString.length; i++) {
      buffer.write(newString[i]);

      if (i == 2 && lenght > 2) {
        buffer.write(_separator);
        offsetLenght += 1; // On espace d'une ligne pour le séparateur
      }

      if (i == 4 && lenght > 4) {
        buffer.write(_separator);
        offsetLenght += 1; // On espace d'une ligne pour le séparateur
      }

      if (i == 6 && lenght > 6) {
        buffer.write(_separator);
        offsetLenght += 1; // On espace d'une ligne pour le séparateur
      }
    }

    final formattedValue = buffer.toString();

    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: offsetLenght),
    );
  }
}
