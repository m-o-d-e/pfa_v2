import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HandDrawnLine extends StatelessWidget {
  const HandDrawnLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: FractionallySizedBox(
        child: Container(
          height: 12,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.green,
                Colors.white.withOpacity(0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
