import 'package:flutter/material.dart';

class CustomConfirmationdialog extends StatelessWidget {
  const CustomConfirmationdialog(
      {super.key,
      this.title,
      this.message,
      this.yes,
      this.no,
      this.pressYes,
      this.pressNo});
  //setting ketentuan untuk di panggil ke funct
  final String? title, message, yes, no;
  final color = Colors.orangeAccent;
  final Function()? pressYes, pressNo;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title!),
      content: Text(message!),
      backgroundColor: color,
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      contentTextStyle: TextStyle(color: Colors.white, fontSize: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: [
        TextButton(
            onPressed: pressNo,
            child: Text(
              no!,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
        TextButton(
            onPressed: pressYes,
            child: Text(
              yes!,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ))
      ],
    );
  }
}
