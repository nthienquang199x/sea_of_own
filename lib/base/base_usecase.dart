abstract class UseCase<T, P> {
  Future<T> call(P params);
}

abstract class UseCaseNoParams<T> {
  Future<T> call();
}

abstract class SubcribeUseCase<T, P> {
  Stream<T> subcribe(P params);
}
