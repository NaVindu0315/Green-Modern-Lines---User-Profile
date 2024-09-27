import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  final String text;

  const TitleRow({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 30.0,
        ),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.black38,
          ),
        ),
      ],
    );
  }
}
