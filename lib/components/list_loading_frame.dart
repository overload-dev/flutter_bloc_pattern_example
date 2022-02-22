import 'package:flutter/material.dart';

class ListLoadingFrame extends StatefulWidget {
  const ListLoadingFrame({Key? key}) : super(key: key);

  @override
  State<ListLoadingFrame> createState() => _ListLoadingFrameState();
}

class _ListLoadingFrameState extends State<ListLoadingFrame>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000), reverseDuration: const Duration(milliseconds: 1000));
    _animationController.repeat(reverse: true);

    _animation = Tween<double>(
      begin: 1.0,
      end: 0.5,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return FadeTransition(
      opacity: _animation,
      child: Container(
        height: 100,
        color: Colors.grey,
      ),
    );
  }
}
