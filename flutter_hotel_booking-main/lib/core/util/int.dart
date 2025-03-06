extension IntDurationX on int {
  Duration get miliseconds => Duration(milliseconds: this);
  Duration get seconds => Duration(seconds: this);
}
