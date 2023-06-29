import 'package:flutter/material.dart';

class OnBoardingSlider extends StatelessWidget {
  const OnBoardingSlider({super.key, required this.slides, this.controller});

  final List<Slide> slides;
  final PageController? controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .5,
      child: PageView.builder(
          controller: controller,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                "assets/${slides[index].image}",
                height: MediaQuery.of(context).size.height * .5,
                fit: BoxFit.fitHeight,
              ),
            );
          }),
    );
  }
}

class Slide {
  final String image;
  final String? text;

  Slide({this.text, required this.image});
}
