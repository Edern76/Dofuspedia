import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget{
  final double size;
  final double borderRadius;
  final Image image;
  final double blurRadius;
  final double spreadRadius;

  RoundedImage({
    required this.size,
    this.borderRadius=10,
    required this.image,
    this.blurRadius=8,
    this.spreadRadius=6,
  });

  @override
  Widget build(BuildContext context){
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.15),
                blurRadius: blurRadius,
                spreadRadius: spreadRadius,
                offset: const Offset(0, 0)
            )
          ]
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(borderRadius),
          child: SizedBox(
              child: image,
              width: size,
              height: size,
          ),
      ),
    );
  }
}