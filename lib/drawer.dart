import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class OffsetPos {
  OffsetPos(this.start, this.end);
  Offset start;
  Offset end;
}

class DrawLine extends CustomPainter {
  Offset start, end;
  List<OffsetPos> offsets = [];

  DrawLine(this.start, this.end, this.offsets);

  @override
  void paint(Canvas canvas, Size size) {
    Logger().i(start, end);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    for (var element in offsets) {
      canvas.drawLine(element.start, element.end, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class DragTargetWidget extends StatefulWidget {
  final Function(String, String) onWillAccept;
  final Function(String) onAccept;
  String? acceptedData;
  String value;
  DragTargetWidget(
      {required this.onWillAccept,
      required this.onAccept,
      required this.value});

  @override
  _DragTargetWidgetState createState() => _DragTargetWidgetState();
}

class _DragTargetWidgetState extends State<DragTargetWidget> {
  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String?> candidateData,
          List<dynamic> rejectedData) {
        return Container(
          width: 50,
          height: 50,
          color: Colors.grey,
          alignment: Alignment.center,
          child: Text(widget.acceptedData ?? 'Sürükleyin'),
        );
      },
      onWillAccept: (data) {
        return widget.onWillAccept(widget.value, data ?? "");
      },
      onAccept: (data) {
        widget.acceptedData = data;
        setState(() {});
        widget.onAccept(data);
      },
    );
  }
}

class DraggableWidget extends StatefulWidget {
  final String text;
  final Function(Offset) onDragStarted;
  final Function(Offset) onDragEnd;

  DraggableWidget(
      {required this.text,
      required this.onDragStarted,
      required this.onDragEnd});

  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: widget.text,
      onDragStarted: () {
        widget.onDragStarted((context.findRenderObject() as RenderBox)
            .localToGlobal(Offset(Offset.zero.dx + 50, 0)));
      },
      onDraggableCanceled: (_, __) {},
      onDragEnd: (detail) {
        widget.onDragEnd(detail.offset);
      },
      child: Container(
        width: 50,
        height: 50,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text(widget.text, style: TextStyle(color: Colors.white)),
      ),
      feedback: Container(
        width: 50,
        height: 50,
        color: Colors.blue.withOpacity(0.7),
        alignment: Alignment.center,
        child: Text(widget.text, style: TextStyle(color: Colors.white)),
      ),
      childWhenDragging: Container(),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String? dragData;
  Offset startPosition = Offset.zero;
  Offset endPosition = Offset.zero;
  List<OffsetPos> items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DraggableWidget(
                        text: 'a',
                        onDragStarted: onDragStarted,
                        onDragEnd: onDragEnd,
                      ),
                      DraggableWidget(
                        text: 'b',
                        onDragStarted: onDragStarted,
                        onDragEnd: onDragEnd,
                      ),
                      // Diğer DraggableWidget'ları buraya ekleyin...
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DragTargetWidget(
                        onWillAccept: onWillAccept,
                        onAccept: onAccept,
                        value: "a",
                      ),
                      DragTargetWidget(
                        onWillAccept: onWillAccept,
                        onAccept: onAccept,
                        value: "b",
                      ),
                      // Diğer DragTargetWidget'ları buraya ekleyin...
                    ],
                  ),
                ],
              ),
              CustomPaint(
                painter: DrawLine(startPosition, endPosition, items),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onDragStarted(Offset offset) {
    setState(() {
      startPosition = offset;
    });
  }

  void onDragEnd(Offset offset) {
    setState(() {
      endPosition = offset;
    });
  }

  bool onWillAccept(String correct, String value) {
    return correct == value;
  }

  void onAccept(String data) {
    setState(() {
      items.add(OffsetPos(startPosition, endPosition));
      setState(() {});
      dragData = data;
    });
  }
}
