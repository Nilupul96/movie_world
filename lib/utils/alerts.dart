// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:movie_world/utils/styles.dart';

// class Alerts {
//   static void _close(BuildContext context,
//       {required Function onCloseCallback}) {
//     Navigator.of(context).pop();
//     if (onCloseCallback != null) {
//       onCloseCallback();
//     }
//   }

//   static void showMessageForResponse(BuildContext context, response,
//       {String title = "Error",
//       String button = "OK",
//       required Function onCloseCallback}) {
//     // String message = ErrorMessages.getErrorMessage(response);
//     showMessage(context, message,
//         title: title, button: button, onCloseCallback: onCloseCallback);
//   }

//   static void showMessage(BuildContext context, String message,
//       {String title = "Error",
//       String button = "OK",
//       required Function onCloseCallback}) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                   topLeft: Radius.circular(8),
//                   bottomRight: Radius.circular(8)),
//             ),
//             child: Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Wrap(
//                   children: <Widget>[
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           title,
//                           style: const TextStyle(
//                               color: DefaultDarkColor, fontSize: 20),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           message,
//                           style: const TextStyle(
//                             color: DefaultDarkColor,
//                             fontSize: 16,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 24,
//                         ),
//                         SizedBox(
//                           height: 48.0,
//                           child: RaisedButton(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             onPressed: () => _close(context,
//                                 onCloseCallback: onCloseCallback),
//                             padding: EdgeInsets.all(12),
//                             color: DefaultDarkColor,
//                             child: Text(
//                               button,
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }

//   static void showConfirmation(
//       BuildContext context,
//       String message,
//       String title,
//       String buttonPositive,
//       String buttonNegative,
//       Function onPositiveCallback,
//       Function onNegativeCallback) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                   topLeft: Radius.circular(8),
//                   bottomRight: Radius.circular(8)),
//             ),
//             child: Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Wrap(
//                   children: <Widget>[
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           title,
//                           style:
//                               TextStyle(color: DefaultDarkColor, fontSize: 20),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           message,
//                           style: TextStyle(
//                             color: DefaultDarkColor,
//                             fontSize: 16,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 24,
//                         ),
//                         SizedBox(
//                           height: 40.0,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: <Widget>[
//                               Expanded(
//                                 child: RaisedButton(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   onPressed: () => _close(context,
//                                       onCloseCallback: onPositiveCallback),
//                                   padding: EdgeInsets.all(5),
//                                   color: DefaultDarkColor,
//                                   child: Text(
//                                     buttonPositive,
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 16),
//                               Expanded(
//                                 child: RaisedButton(
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   onPressed: () => _close(context,
//                                       onCloseCallback: onNegativeCallback),
//                                   padding: EdgeInsets.all(5),
//                                   color: DefaultDarkColor,
//                                   child: Text(
//                                     buttonNegative,
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 8,
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }
