import 'package:flutter/material.dart';

class AdvetiseMarquee extends StatefulWidget {
  const AdvetiseMarquee({Key? key}) : super(key: key);

  @override
  State<AdvetiseMarquee> createState() => _AdvetiseMarqueeState();
}

class _AdvetiseMarqueeState extends State<AdvetiseMarquee> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.15,
      width: screenWidth * 0.95,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 5),
              blurRadius: 20,
              color: Colors.black.withOpacity(0.5),
            ),
          ]),
      child: const Center(
          child: Text(
        'Advertisement',
        style: TextStyle(fontSize: 40),
      )),
    );
  }
}
