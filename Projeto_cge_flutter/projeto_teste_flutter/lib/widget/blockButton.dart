
import 'package:flutter/material.dart';

class BlockButton extends StatelessWidget {

  final IconData icon;
  final String label;
  final Function()? onPressed;
  final buttonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 18),
    padding: const EdgeInsets.all(10),
    minimumSize: const Size(190, 40),
    backgroundColor: const Color.fromARGB(255, 175, 31, 21),
    shadowColor: Colors.black,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40)))
  );

  BlockButton({super.key, required this.icon, required this.label, required this.onPressed});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton.icon(onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: buttonStyle,
        ),
    );
  }
}