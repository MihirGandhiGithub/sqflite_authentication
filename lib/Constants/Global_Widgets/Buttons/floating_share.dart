import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class FloatingButton extends StatelessWidget {
  final bool isVisible;
  final ScreenshotController screenshotController; // Updated parameter type

  const FloatingButton({
    Key? key,
    required this.screenshotController,
    required this.isVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isVisible
        ? const SizedBox()
        : FloatingActionButton(
            onPressed: () async {
              Uint8List? img = await screenshotController.capture();
              int counter = 0;
              if (img != null) {
                // Create a temporary directory to save the image file
                Directory tempDir = await getTemporaryDirectory();
                String tempPath = tempDir.path;

                // Generate a unique file name for the image
                String fileName = 'TextileCalculatorScreenshot$counter.jpg';
                String filePath = '$tempPath/$fileName';

                // Write the Uint8List to the file
                await File(filePath).writeAsBytes(img);
                counter++;

                // Share the file
                await Share.shareFiles(
                  [filePath],
                  // subject: 'Snapshot From Textile Calculator'
                  text: 'Snapshot From Textile Calculator',
                );
              }
            },
            backgroundColor: Colors.blue,
            child: const Icon(
              Icons.share,
              color: Colors.white,
            ),
          );
  }
}
