import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

part 'add_content_state.dart';

class AddContentCubit extends Cubit<AddContentState> {
  //TODO: add a user case to create a new post and save it.

  AddContentCubit() : super(AddContentState.initialize());

  void videoChanged(File file) {
    emit(state.copyWith(
        video: file, addContentStatus: AddContentStatus.loading));
  }

  void caotionChanged(String caption) {
    emit(state.copyWith(
        caption: caption, addContentStatus: AddContentStatus.loading));
  }

  void submit() {}

  void reset() {
    emit(AddContentState.initialize());
  }
}
