class RouterPaths {
  RouterPaths._();

  static const String DASHBOARD = "/";

  static const String POLICY = "/policy/:id";
  static String TO_POLICY(String pId) => "/policy/$pId";

  static const String CLAIM = "/policy/:id/claim";
  static String TO_CLAIM(String pId) => "/policy/$pId/claim";
}
