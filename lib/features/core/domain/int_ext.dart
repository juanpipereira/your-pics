extension IntExt on int {
  String toDecimal() => toString().padLeft(2, '0');
}
