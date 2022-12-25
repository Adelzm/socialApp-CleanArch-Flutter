import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:social_media_clean_archi/src/shared/presentation/widgets/widgets.dart';

import '../blocs/add_content/add_content_cubit.dart';

class AddContentScreen extends StatelessWidget {
  const AddContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Content'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AddContentCubit>().reset();
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<AddContentCubit, AddContentState>(
        buildWhen: (previous, current) => previous.video != current.video,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state.video == null) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  _handleVideo().then((video) {
                    if (video != null) {
                      context.read<AddContentCubit>().videoChanged(video);
                    }
                  });
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
            );
          } else {
            return CustomVideoPlayController(assetPath: state.video!.path);
          }
        },
      ),
    );
  }

  Future<File?> _handleVideo() async {
    XFile? uploadVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (uploadVideo == null) {
      return null;
    }

    final directory = await getApplicationDocumentsDirectory();
    final fileName = p.basename(uploadVideo.path);
    final savedVideo =
        await File(uploadVideo.path).copy('${directory.path}/$fileName');

    return savedVideo;
  }
}
