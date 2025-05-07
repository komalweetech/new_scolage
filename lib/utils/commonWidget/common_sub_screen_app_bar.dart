import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonSubScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CommonSubScreenAppBar({super.key, this.actions,this.title});
  final List<Widget>? actions;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? " "),
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: actions,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

