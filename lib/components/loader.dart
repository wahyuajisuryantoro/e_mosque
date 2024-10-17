import 'package:flutter/material.dart';

class GlobalLoader {
  
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false, 
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, 
              children: [
                CircularProgressIndicator(
                  color: Colors.green, 
                ),
                SizedBox(height: 15),
                Text(
                  'Sedang Memuat....',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
