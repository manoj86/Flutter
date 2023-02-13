import 'package:flutter/cupertino.dart';

class Animator extends StatefulWidget {
  late TextStyle? style;
  ValueNotifier<String> displayText = ValueNotifier<String>('');

  Animator({ super.key, this.style, });

  @override
  State<Animator> createState() => _AnimatorState();
}


class _AnimatorState extends State<Animator> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    widget.displayText.addListener(() {
      setState(() {});
    });
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 400),
    vsync: this,
  );

  late final Animation<double> fadeAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeIn,
  )..addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      _animationController.stop();
    }
  });

  @override
  Widget build(BuildContext context) {
    startAnimation();
    return  FadeTransition(
        opacity: fadeAnimation,
        child: Text(widget.displayText.value, style: widget.style,)
    );
  }

  startAnimation() {
    _animationController.forward(from: 0);
  }
}