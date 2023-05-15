import 'package:carrot_clone_app/Widgets/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  RoundedInputField(
      {required this.hintText,
      this.icon = Icons.person,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: Colors.orange,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.orange,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
