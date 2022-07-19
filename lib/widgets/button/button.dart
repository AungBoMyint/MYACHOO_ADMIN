import 'package:flutter/material.dart';

class ExButton extends StatelessWidget {
  final String? label;
  final Color? labelColor;
  final Function? onPressed;
  final Color? color;
  final IconData? icon;
  final double? height;
  final double? fontSize;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;

  ExButton({
     this.label,
     this.labelColor,
     this.onPressed,
     this.color,
     this.icon,
     this.height,
     this.fontSize,
     this.borderRadius,
     this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed!(),
      child: Container(
        height: height ,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius ,
          boxShadow: boxShadow,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 16.0,
            right: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$label",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  color: labelColor
                      ,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
