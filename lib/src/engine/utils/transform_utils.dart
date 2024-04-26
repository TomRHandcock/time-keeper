extension TransformUtils<T> on T {
  S let<S>(S Function(T it) transform) => transform(this);

  S? asOrNull<S>() => this is S ? this as S : null;

  T? takeIf(bool Function(T) predicate) => predicate(this) ? this : null;

  T? takeUnless(bool Function(T) predicate) => predicate(this) ? null : this;
}