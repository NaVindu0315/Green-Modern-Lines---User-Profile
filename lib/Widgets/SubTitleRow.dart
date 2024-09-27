import 'package:flutter/material.dart';

class SubtitleRow extends StatelessWidget {
  final String text;

  const SubtitleRow({
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
