import 'package:flutter/material.dart';
import 'package:homi/helper/helper.dart';

class ProgressDialog extends StatelessWidget {
  final String message;
  const ProgressDialog({Key? key, this.message = ''}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: dPurple,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            const SizedBox(width: 6,),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            const SizedBox(width: 15,),
            Expanded(child: sText("$message",color: Colors.white,size: 16))
          ],
        ),
      ),
    );
  }
}
