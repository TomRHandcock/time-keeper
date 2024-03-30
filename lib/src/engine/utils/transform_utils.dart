extension TransformUtils<T> on T {
  S let<S>(S Function(T it) transform) => transform(this);

  S? asOrNull<S>() => this is S ? this as S : null;
}