class HomeState {
  final String bmiComment;

  HomeState({
    this.bmiComment = '',
  });
  HomeState copyWith({
    String? bmiComment,
  }) {
    return HomeState(
      bmiComment: bmiComment ?? this.bmiComment,
    );
  }
}
