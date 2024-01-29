abstract interface class UiState<T> {}

class InitialState<T> extends UiState<T> {}

class LoadingState<T> extends UiState<T> {}

class SuccessState<T extends Object> extends UiState<T> {
  final T data;

  SuccessState(this.data);
}