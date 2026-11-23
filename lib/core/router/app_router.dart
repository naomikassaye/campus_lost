import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:campus_lost/core/router/app_routes.dart';
import 'package:campus_lost/core/widgets/placeholder_page.dart';

import 'package:campus_lost/features/auth/presentation/login_screen.dart';
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
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.feed,
        builder: (context, state) => const FeedScreen(),
      ),
      GoRoute(
        path: AppRoutes.itemDetailsPattern,
        builder: (context, state) =>
            ItemDetailsScreen(itemId: state.pathParameters['itemId']!),
      ),
      GoRoute(
        path: AppRoutes.report,
        builder: (context, state) => const ReportItemScreen(),
      ),
      GoRoute(
        path: AppRoutes.claimFormPattern,
        builder: (context, state) =>
            ClaimFormScreen(itemId: state.pathParameters['itemId']!),
      ),
      GoRoute(
        path: AppRoutes.activity,
        builder: (context, state) => const MyActivityScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.reviewClaims,
        builder: (context, state) {
          // TODO: Restrict this route to authenticated Custodian users.
          return const ReviewClaimsScreen();
        },
      ),
    ],
    errorBuilder: (context, state) =>
        const PlaceholderPage(title: 'Page not found'),
  );
});
