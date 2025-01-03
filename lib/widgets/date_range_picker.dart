import 'package:flutter/material.dart';

/// A widget that allows users to select a date range.
class DateRangePicker extends StatelessWidget {
  /// Constructor
  const DateRangePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '2000/01/01',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '2100/01/01',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 100,
          width: double.infinity,
          child: Stack(
            children: [
              const DateRangePickerLine(),
              DateRangePickerCircle(
                isStart: true,
                onTap: () {
                  print('Tapped Start Circle');
                },
              ),
              DateRangePickerCircle(
                isStart: false,
                onTap: () {
                  print('Tapped End Circle');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A circle of the date range.
class DateRangePickerCircle extends StatefulWidget {
  /// Constructor
  const DateRangePickerCircle({
    required this.isStart,
    required this.onTap,
    super.key,
  });

  /// Is start
  final bool isStart;

  /// On tap event
  final VoidCallback onTap;

  @override
  DateRangePickerCircleState createState() => DateRangePickerCircleState();
}

/// A state of the date range picker circle.
class DateRangePickerCircleState extends State<DateRangePickerCircle>
    with TickerProviderStateMixin {
  late final _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);
  late final _animation = Tween<double>(begin: 0.7, end: 1.3).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left:
          (widget.isStart ? 0.2 : 0.8) * MediaQuery.of(context).size.width - 10,
      top: 40,
      child: GestureDetector(
        onTap: widget.onTap,
        child: ScaleTransition(
          scale: _animation,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

/// A line of the date range.
class DateRangePickerLine extends StatelessWidget {
  /// Constructor
  const DateRangePickerLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 100),
      painter: DateRangePickerLinePainter(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

/// A custom painter for the date range picker UI.
class DateRangePickerLinePainter extends CustomPainter {
  /// Constructor
  DateRangePickerLinePainter({
    required this.color,
  });

  /// Color
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final startX = 0.2 * size.width;
    final endX = 0.8 * size.width;

    canvas.drawLine(
      Offset(startX, size.height / 2),
      Offset(endX, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
