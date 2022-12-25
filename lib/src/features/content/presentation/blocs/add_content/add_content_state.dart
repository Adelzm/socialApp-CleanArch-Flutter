part of 'add_content_cubit.dart';

enum AddContentStatus { intial, loading, success, error }

class AddContentState extends Equatable {
  final File? video;
  final String caption;
  final AddContentStatus addContentStatus;

  const AddContentState({
    required this.video,
    required this.caption,
    required this.addContentStatus,
  });

  factory AddContentState.initialize() {
    return const AddContentState(
      video: null,
      caption: '',
      addContentStatus: AddContentStatus.intial,
    );
  }

  AddContentState copyWith(
      {File? video, String? caption, AddContentStatus? addContentStatus}) {
    return AddContentState(
      video: video ?? this.video,
      caption: caption ?? this.caption,
      addContentStatus: addContentStatus ?? this.addContentStatus,
    );
  }

  @override
  List<Object?> get props => [video, caption, addContentStatus];
}
