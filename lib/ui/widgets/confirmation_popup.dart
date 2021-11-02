import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationPopup {
  static void _close(BuildContext context, {Function? onCloseCallback}) {
    Navigator.of(context).pop();
    if (onCloseCallback != null) {
      onCloseCallback();
    }
  }

  static void showMessage(BuildContext context, String message,
      {String? title, Function? onCloseCallback}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          final bsv = 8;
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
            ),
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(bsv * 1.9),
                child: Wrap(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(width: double.infinity),
                        SizedBox(
                            width: bsv * 4,
                            height: bsv * 3.8,
                            child: Icon(Icons.exit_to_app)),
                        SizedBox(
                          height: bsv * 2.2,
                        ),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontSize: bsv * 2.4,
                          ),
                        ),
                        SizedBox(
                          height: bsv * 2.4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: bsv * 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: EdgeInsets.all(12),
                                  ),
                                  onPressed: () => _close(context,
                                      onCloseCallback: onCloseCallback),
                                  child: Text(
                                    "Cancel",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: bsv * 5,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color(0xff00BA32),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                  onPressed: () => _close(context,
                                      onCloseCallback: onCloseCallback),
                                  child: Text(
                                    "Ok",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
