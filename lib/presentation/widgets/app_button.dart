import 'package:amritha_ayurvedha/core/constants/font_strings.dart';
import 'package:amritha_ayurvedha/presentation/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String btntext;
  final String? family;
  final Color? color, bgColor;
  final VoidCallback? onTap;
  final double? width, radius, verticalPadding, textSize;
  final bool isOutlinedBtn;
  final Color? borderColor;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.btntext,
    this.family,
    this.color,
    this.bgColor,
    this.onTap,
    this.radius,
    this.isOutlinedBtn = false,
    this.width,
    this.textSize,
    this.verticalPadding,
    this.borderColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width ?? double.infinity,
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 5),
          color: isOutlinedBtn ? Colors.transparent : bgColor ?? Colors.blue,
          border: isOutlinedBtn
              ? Border.all(color: borderColor ?? Colors.blue, width: 1)
              : null,
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: color ?? Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : AppText.click(
                  onTap: onTap,
                  btntext,
                  color: color ?? const Color(0xFFffe17d),
                  align: TextAlign.center,
                  family: family ?? poppins600,
                  size: textSize ?? 16,
                ),
        ),
      ),
    );
  }
}
