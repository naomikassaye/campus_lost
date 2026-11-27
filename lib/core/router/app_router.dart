import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_lost/core/router/app_routes.dart';
import 'package:campus_lost/core/widgets/app_shell.dart';
import 'package:campus_lost/core/widgets/placeholder_page.dart';

import 'package:campus_lost/features/auth/presentation/login_screen.dart';
import 'package:campus_lost/features/auth/presentation/providers/auth_providers.dart';
import 'package:campus_lost/features/feed/presentation/feed_screen.dart';
import 'package:campus_lost/features/item_details/presentation/item_details_screen.dart';
import 'package:campus_lost/features/report_item/presentation/report_item_screen.dart';
import 'package:campus_lost/features/claim/presentation/claim_form_screen.dart';
import 'package:campus_lost/features/my_activity/presentation/my_activity_screen.dart';
import 'package:campus_lost/features/profile/presentation/profile_screen.dart';
import 'package:campus_lost/features/review_claims/presentation/review_claims_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.login,
    redirect: (context, state) {
      final user = ref.read(currentUserProvider);
      final location = state.matchedLocation;

      if (user == null && location != AppRoutes.login) {
        return AppRoutes.login;
      }
      if (user != null && location == AppRoutes.login) {
        return AppRoutes.feed;
      }
      if (location == AppRoutes.reviewClaims &&
          user != null &&
          !user.isCustodian) {
        return AppRoutes.feed;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.feed,
                builder: (context, state) => const FeedScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.report,
                builder: (context, state) => const ReportItemScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.activity,
                builder: (context, state) => const MyActivityScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.itemDetailsPattern,
        builder: (context, state) =>
            ItemDetailsScreen(itemId: state.pathParameters['itemId']!),
      ),
      GoRoute(
        path: AppRoutes.claimFormPattern,
        builder: (context, state) =>
            ClaimFormScreen(itemId: state.pathParameters['itemId']!),
      ),
      GoRoute(
        path: AppRoutes.reviewClaims,
        builder: (context, state) => const ReviewClaimsScreen(),
      ),
    ],
    errorBuilder: (context, state) =>
        const PlaceholderPage(title: 'Page not found'),
  );
});
