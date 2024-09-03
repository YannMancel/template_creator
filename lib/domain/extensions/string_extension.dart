extension StringExt on String {
  bool get isNetworkUrl => startsWith('http');
}
