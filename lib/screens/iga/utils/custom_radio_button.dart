import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  final String text;
  final String description;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;
  final bool isThisCorrect;

  const CustomRadioButton(
      {super.key,
      required this.text,
      required this.isSelected,
      required this.onChanged,
      required this.isThisCorrect,
      required this.description});

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.isSelected);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.006),
              margin: EdgeInsets.fromLTRB(
                  0, 0, 0, MediaQuery.of(context).size.height * 0.015),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: widget.isSelected && widget.isThisCorrect
                        ? Colors.green
                        : widget.isSelected && !widget.isThisCorrect
                            ? Colors.red
                            : Colors.grey,
                    offset: const Offset(0, 4),
                    blurRadius: 2,
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: widget.isSelected && widget.isThisCorrect
                      ? Colors.green
                      : widget.isSelected && !widget.isThisCorrect
                          ? Colors.red
                          : Colors.grey,
                  width: 1.0,
                ),
              ),

              // THE OPTION: CHECKMARK, TEXT
              child: Row(
                children: [
                  Container(
                    width: 28.0,
                    height: 28.0,
                    margin: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: widget.isSelected ? Colors.black : Colors.grey,
                        width: MediaQuery.of(context).size.height * 0.002,
                      ),
                    ),

                    // THE CHECKMARK OR CROSS
                    child: widget.isSelected
                        ? Icon(
                            widget.isThisCorrect
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: widget.isThisCorrect
                                ? Colors.green
                                : Colors.red,
                            size: 24.0,
                          )
                        : Container(),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      widget.text,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // THE DESCRIPTION SUBTITLE IF SELECTED
            widget.isSelected
                ? Wrap(
                    children: [
                      widget.isThisCorrect
                          ? const Text('Wabikoze! ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold))
                          : const Align(
                              alignment: Alignment.topLeft,
                              child: Text('Ongera ugerageze!',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025),
                      Text(
                        textAlign: TextAlign.left,
                        widget.isThisCorrect ? widget.description : '',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black.withOpacity(0.9),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
