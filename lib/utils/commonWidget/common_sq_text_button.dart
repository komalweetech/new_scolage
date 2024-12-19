import 'package:flutter/material.dart';

class CommonSqTextButton extends StatelessWidget {
  const CommonSqTextButton(
      {super.key,
      this.onTap,
      required this.name,
      this.color,
      required this.isSelected,
      this.fontSize});
  final VoidCallback? onTap;
  final String name;
  final Color? color;
  final bool isSelected;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.black : Colors.transparent,
              width: 1,
            ),
          ),
        ),
        child: Text(
          name,
          style: TextStyle(
            fontSize: fontSize ?? 15,
            color: color,fontFamily: "Poppins",fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}
