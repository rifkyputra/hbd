abstract class State {}

class Ok<T> extends State {
  final T value;

  Ok(this.value);
}

class Err<E extends Exception> extends State {
  final E exception;
  final StackTrace? stacktrace;
  final String? message;

  Err({
    required this.exception,
    this.stacktrace,
    this.message,
  });
}

class Loading extends State {}

class Init extends State {}
