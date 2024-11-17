import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Utils/cameroon_phone_format.dart';

class PhoneNumberInputComponent extends StatelessWidget {
  const PhoneNumberInputComponent(
      {super.key,
      required this.textController,
      this.errorText,
      this.autofocus});

  final TextEditingController textController;
  final String? errorText;
  final bool? autofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 50.0,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: Theme.of(context).dividerColor),
              right:
                  BorderSide(width: 1, color: Theme.of(context).dividerColor),
              bottom:
                  BorderSide(width: 1, color: Theme.of(context).dividerColor),
              left: BorderSide(width: 1, color: Theme.of(context).dividerColor),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Expanded(
                  flex: 1,
                  child: Flag.fromString(
                    'CM',
                    fit: BoxFit.contain,
                    height: 20.0,
                    flagSize: FlagSize.size_4x3,
                  )),
              Expanded(
                flex: 5,
                child: TextFormField(
                    controller: textController,
                    autofocus: autofocus ?? true,
                    maxLines: 1,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        icon: Text('+237'), border: InputBorder.none),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(9),
                      CameroonPhoneNumberFormatter()
                    ]),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),

        // Le message d'erreur du TextFormField
        Text(
          errorText ?? "",
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ],
    );
  }
}
