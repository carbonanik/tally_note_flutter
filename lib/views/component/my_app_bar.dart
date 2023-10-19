import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget title;

  @override
  final Size preferredSize;

  const MyAppBar({
    Key? key,
    this.leading,
    this.actions,
    this.centerTitle = false,
    required this.title,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      actions: actions,
      backgroundColor: Colors.grey[900],
      elevation: 0,
      // flexibleSpace: ClipRect(
      //   child: BackdropFilter(
      //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      //     child: Container(
      //       color: Colors.transparent,
      //     ),
      //   ),
      // ),
      centerTitle: centerTitle,
      title: title,

    );
  }
}
