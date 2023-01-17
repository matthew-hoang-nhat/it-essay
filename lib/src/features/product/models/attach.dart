class Attach {
  Attach({
    this.pathLocalUrl,
    this.pathServerUrl,
  });
  final String? pathLocalUrl;
  final String? pathServerUrl;
  bool get isLocal => pathLocalUrl == null;
}
