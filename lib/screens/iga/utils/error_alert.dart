import 'package:flutter/material.dart';

class ErrorAlert extends StatelessWidget {
  final String errorTitle;
  final String errorMsg;
  final String? firstButtonTitle;
  final Function? firstButtonFunction;
  final String? secondButtonTitle;
  final Function? secondButtonFunction;

  const ErrorAlert(
      {super.key,
      required this.errorTitle,
      required this.errorMsg,
      this.firstButtonTitle,
      this.firstButtonFunction,
      this.secondButtonTitle,
      this.secondButtonFunction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        errorTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 0, 0),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 27, 116),
      content: Text(
        errorMsg,
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
        side: const BorderSide(
          color: Color.fromARGB(255, 255, 255, 255),
          width: 3.0,
        ),
      ),
      shadowColor: const Color.fromARGB(255, 0, 0, 0),
      actions: [
        TextButton(
            onPressed: () {
              firstButtonTitle != null
                  ? firstButtonFunction!()
                  : Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
                color: const Color.fromARGB(255, 255, 0, 0),
              ),
              child: Text(
                firstButtonTitle ?? 'Funga',
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            )),

        // IF SECOND BUTTON TITLE IS NOT NULL
        if (secondButtonTitle != null)
          TextButton(
              onPressed: () {
                secondButtonFunction!();
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color.fromARGB(255, 255, 0, 0),
                ),
                child: Text(
                  secondButtonTitle ?? 'Funga',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              )),
      ],
    );
  }
}
