import 'package:flutter/material.dart';

class WinningPainter extends CustomPainter {
final int startIndex;
final int endIndex;
WinningPainter(this.startIndex, this.endIndex);

  @override
  void paint(Canvas canvas, Size size) {
    final paint=Paint();
    paint.color=Colors.red;
    paint.strokeWidth=10.0;
    paint.strokeCap=StrokeCap.round;
    final double cellWidth=size.width/3;
    final double cellHeight=size.height/3;
    int startCol=startIndex%3;
    int startRow=startIndex~/3;
    final start=Offset(
      (startCol*cellWidth)+(cellWidth/2)
      , (startRow*cellHeight)+(cellHeight/2));
    int endCol=endIndex%3;
    int endRow=endIndex~/3;
    final end=Offset(
      (endCol*cellWidth)+(cellWidth/2)
      , (endRow*cellHeight)+(cellHeight/2)
      );
      canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant WinningPainter oldDelegate)
  {
    if (this.startIndex!=oldDelegate.startIndex)
    {
      return true;
    }
    return false;
  }


}