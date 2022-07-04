import 'package:flutter/material.dart';

class LocalTime extends StatefulWidget {
  const LocalTime({Key? key, required this.dateTime})
      : super(key: key);

  final dynamic dateTime;

  @override
  State<LocalTime> createState() => _LocalTimeState();
}

class _LocalTimeState extends State<LocalTime> {
  @override
  Widget build(BuildContext context) {
    return Text(
      '${DateTime.fromMillisecondsSinceEpoch(widget.dateTime*1000).year}-${DateTime.fromMillisecondsSinceEpoch(widget.dateTime*1000).month}-${DateTime.fromMillisecondsSinceEpoch(widget.dateTime*1000).day}',
        style: const TextStyle(
            color: Colors.white, fontSize: 24, fontFamily: 'Arial'));
  }
}

