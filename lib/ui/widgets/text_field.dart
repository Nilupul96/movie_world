import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LyfTextFormField extends StatefulWidget {
  final String labelText;

  //final  onSaved;
  final Widget? suffix;
  final TextInputType keyboardType;
  final bool isPassword;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final void Function(String myString) onFieldSubmitted;

  final TextEditingController textEditingController;

  LyfTextFormField({
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.textInputAction = TextInputAction.next,
    required this.focusNode,
    required this.onFieldSubmitted,
    required this.textEditingController,
    this.suffix,
  });

  @override
  State<LyfTextFormField> createState() => _LyfTextFormFieldState();
}

class _LyfTextFormFieldState extends State<LyfTextFormField> {
  bool _isObscure = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: TextFormField(
        controller: widget.textEditingController,
        focusNode: widget.focusNode,
        onFieldSubmitted: widget.onFieldSubmitted,
        textInputAction: widget.textInputAction,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          suffix: widget.suffix,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    !_isObscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.lightBlueAccent,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  })
              : const SizedBox(),
          labelStyle: const TextStyle(
              color: Colors.lightBlueAccent, fontWeight: FontWeight.w500),
          labelText: widget.labelText,
          // contentPadding:
          //     EdgeInsets.symmetric(horizontal: bsv * 0, vertical: bsv * 1),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.transparent,
          focusedBorder: const UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 2.0)),
          enabledBorder: const UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 2.0)),
          errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0)),
          focusedErrorBorder: const UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.lightBlueAccent, width: 2.0)),
        ),
        obscureText: _isObscure,
        validator: (String? value) {
          // switch (widget.type) {
          //   case TextFieldType.NORMAL:
          //     if (value!.isEmpty) {
          //       return widget.labelText + isRequired[index!];
          //     }
          //     break;
          //   case TextFieldType.OPTIONAL:
          //     return null;
          //   case TextFieldType.EMAIL:
          //     return validateEmail(value!, index!);
          //   case TextFieldType.PASSWORD:
          //   default:
          //     return validatePassword(value!, index!);
          // }
        },

        keyboardType: widget.keyboardType,
        //onTap: onTap,
      ),
    );
  }
}

String? validateEmail(String value, int index) {
  var pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    // return enterValidEmail[index];
  }
  return null;
}

String? validatePassword(String value, int index) {
  var pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
  RegExp regExp = RegExp(pattern);
  if (!regExp.hasMatch(value)) {
    // return invalidPassword[index];
  }
  return null;
}
