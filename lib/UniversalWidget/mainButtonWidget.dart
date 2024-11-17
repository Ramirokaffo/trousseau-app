import 'package:flutter/material.dart';

class MainButtonWidget extends StatelessWidget {
  const MainButtonWidget(
      {Key? key,
      required this.isPrimaryBtn,
      this.onPressed,
      required this.label,
      this.isLoading})
      : super(key: key);
  final bool isPrimaryBtn;
  final String label;
  final bool? isLoading;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: isPrimaryBtn
            ? SizedBox(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: (isLoading ?? false) ? () {} : onPressed,
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Theme.of(context).colorScheme.primary),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3)))),
                  child: !(isLoading ?? false)
                      ? Text(
                          label,
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        )
                      : CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                ),
              )
            : SizedBox(
                height: 50.0,
                child: TextButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      foregroundColor:
                          Theme.of(context).textTheme.bodyMedium?.color,
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              3)) // Bordure jaune de 2 pixels
                      ),
                  child: Text(
                    label,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ));
  }
}
