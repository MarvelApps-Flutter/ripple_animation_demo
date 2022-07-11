import 'package:flutter/material.dart';

import '../widget/circle_painter.dart';
import '../widget/curve_wave_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    this.size = 90.0,
    this.color = Colors.blue,
  }) : super(key: key);
  final double size;
  final Color color;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
    );
  }

  AppBar _appbar() {
    return AppBar(
      title: const Text("Ripple Animation Module"),
      centerTitle: true,
    );
  }

  Center _body() {
    return Center(
      child: CustomPaint(
        painter: CirclePainter(
          _controller,
          color: widget.color,
        ),
        child: SizedBox(
          width: widget.size * 3.5,
          height: widget.size * 3.5,
          child: _button(),
        ),
      ),
    );
  }

  Widget _button() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.size),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: <Color>[widget.color, widget.color.withOpacity(0.5)],
            ),
          ),
          child: ScaleTransition(
              scale: Tween(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: const CurveWave(),
                ),
              ),
              child: const Icon(
                Icons.mic,
                size: 44,
              )),
        ),
      ),
    );
  }
}
