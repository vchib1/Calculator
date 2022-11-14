import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class MyButton extends StatelessWidget {

  final Color;
  final textColor;
  final String buttonText;

  final buttonTapped;

  const MyButton({Key? key,
    required this.Color,
    required this.buttonText,
    required this.textColor,
    required this.buttonTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(color: textColor,fontSize: 20,fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
