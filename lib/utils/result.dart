abstract class Result<V, E> {
  Result._();

  factory Result.value(V value) => _Value<V, E>._(value);
  factory Result.error(E error) => _Error<V, E>._(error);

  _Error<V, E> get _asError => this as _Error<V, E>;
  _Value<V, E> get _asValue => this as _Value<V, E>;

  bool get isError;
  bool get isValue;

  /// use in places where `this` is guaranteed to be a value
  V get asValue => (this as _Value<V, E>)._value;

  /// use in places where `this` is guaranteed to be an error
  E get asError => (this as _Error<V, E>)._error;

  V? get valueOrNull => isValue ? asValue : null;

  V? valueOr(V? Function(E e) or) {
    return isValue ? _asValue._value : or(_asError._error);
  }

  Result<VM, E> mapValue<VM>(VM Function(V v) value) {
    return isError ? Result.error(asError) : Result.value(value(asValue));
  }

  Result<V, EM> mapError<EM>(EM Function(E e) error) {
    return isValue ? Result.value(asValue) : Result.error(error(asError));
  }

  Result<VM, EM> map<VM, EM>({
    required VM Function(V v) value,
    required EM Function(E e) error,
  }) {
    return isValue
        ? Result.value(value(_asValue._value))
        : Result.error(error(_asError._error));
  }

  R incase<R>({
    required R Function(V v) value,
    required R Function(E e) error,
  }) {
    return isValue ? value(_asValue._value) : error(_asError._error);
  }

  Stream<R> asyncIncase<R>({
    Stream<R> Function(V v)? value,
    Stream<R> Function(E e)? error,
  }) {
    return isValue
        ? value?.call(_asValue._value) ?? const Stream.empty()
        : error?.call(_asError._error) ?? const Stream.empty();
  }
}

class _Value<V, E> extends Result<V, E> {
  _Value._(this._value) : super._();

  final V _value;

  @override
  bool get isError => false;

  @override
  bool get isValue => true;
}

class _Error<V, E> extends Result<V, E> {
  _Error._(this._error) : super._();

  final E _error;

  @override
  bool get isError => true;

  @override
  bool get isValue => false;
}
