import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class AddContentScreen extends StatelessWidget {
  const AddContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Content'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              _handleVideo();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            child: Text(
              'Select a Video',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleVideo() async {
    XFile? uploadVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (uploadVideo == null) {
      return null;
    }

    final directory = await getApplicationDocumentsDirectory();
    final fileName = basename(uploadVideo.path);
    final savedVideo =
        await File(uploadVideo.path).copy('${directory.path}/$fileName');

    print(savedVideo);
  }
}
