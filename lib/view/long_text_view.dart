import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking/helper/constant.dart';

import '../controller/long_text_controller.dart';

class LongTextView extends StatelessWidget {
  final LongTextController _controller = Get.put(LongTextController());

  final String text;

  LongTextView({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Description:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 10.0),
        GestureDetector(
          onTap: () => _controller.toggleExpansion(),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              const int maxLength = 290;
              final displayText = text.length > maxLength
                  ? text.substring(0, maxLength)
                  : text;
              return Obx(() {
                final textSpan = _controller.isExpanded.value
                    ? TextSpan(
                        text: text,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      )
                    : TextSpan(
                        text: displayText,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      );
                return RichText(
                  text: TextSpan(
                    children: [
                      textSpan,
                      if (text.length > maxLength &&
                          !_controller.isExpanded.value)
                        TextSpan(
                          text: " Read more...",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: darkblue,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _controller.toggleExpansion,
                        ),
                    ],
                  ),
                );
              });
            },
          ),
        ),
      ],
    );
  }
}
