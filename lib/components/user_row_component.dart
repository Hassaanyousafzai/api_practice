import 'package:flutter/material.dart';

class RowDesign extends StatelessWidget {
  const RowDesign({Key? key, required this.text, required this.value})
      : super(key: key);

  final String text, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(text,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              value,
              textAlign: TextAlign.justify,
            ),
          )
        ],
      ),
    );
  }
}
