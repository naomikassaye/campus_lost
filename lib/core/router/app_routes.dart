class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String feed = '/feed';
  static const String report = '/report';
  static const String activity = '/activity';
  static const String profile = '/profile';
  static const String reviewClaims = '/review-claims';

  // Route patterns used by GoRouter.
  static const String itemDetailsPattern = '/items/:itemId';
  static const String claimFormPattern = '/items/:itemId/claim';

  // Paths used when navigating to a specific item.
  static String itemDetails(String id) => '/items/$id';
  static String claimForm(String id) => '/items/$id/claim';
}
