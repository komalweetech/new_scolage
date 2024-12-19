import '../commonFunction/common_function.dart';
import 'package:flutter/cupertino.dart';

class KeyBoardOff extends StatelessWidget {
  const KeyBoardOff({Key? key, required this.child, this.onTap})
      : super(key: key);
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CommonFunction.keyboardOff(context);
      },
      child: child,
    );
  }
}
