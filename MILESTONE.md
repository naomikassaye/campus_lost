# Milestone 1 Report

## 1. Implementation Status

### Completed

- Implemented all eight proposed screen groups:
  1. Login/Register
  2. Profile & Settings
  3. Feed
  4. Item Details
  5. Report Item
  6. Claim Form
  7. My Activity
  8. Review Claims
- Established the feature-first project structure under `lib/core` and `lib/features`.
- Registered the application screens and routes using `go_router`.
- Implemented bottom navigation and parameterized item detail and claim routes.
- Implemented application state management using Riverpod providers.
- Created Freezed models for application data and state.
- Implemented repository interfaces and in-memory repository implementations.
- Implemented role-based access for student and custodian functionality.
- Implemented report submission, feed display, claim submission, claim review, approval, rejection and item-return workflows.
- Added automated unit and widget tests.
- Manually tested the main student and custodian workflow in Chrome: a student submitted a claim, the claim appeared in My Activity, a custodian approved it, and the item was subsequently marked as returned.

### Not Yet Implemented

- Persistent local storage and offline synchronization.
- Firebase Authentication and Cloud Firestore integration.
- Persistent image storage using Firebase Storage.
- REST-based location search and geocoding.
- AI-based item matching.
- Production backend and deployment.

## 2. Pull Request Contributions

| Member                   | Pull requests authored |
| ------------------------ | ---------------------- |
| Naomi Kassaye Tuffa      | #1, #4, #8, #10 , #11             |
| Solyana Alemseged Zewdie | #2, #7                 |
| Meron Mulugeta Mehari    | #6                     |
| Maryamawit Lemma         | #3, #5, #9             |

## 3. Pull Request Reviews

All nine implementation pull requests were reviewed before merging. No pull request was merged without review.

| Member                   | Pull requests reviewed |
| ------------------------ | ---------------------- |
| Naomi Kassaye Tuffa      | #3, #7, #9             |
| Solyana Alemseged Zewdie | #1, #8                 |
| Meron Mulugeta Mehari    | #4, #5                 |
| Maryamawit Lemma         | #2, #6, #10 ,#11                 |

## 4. Group Self-Assessment

The group assessed its work against the official Milestone 1 mini-rubric.

| Criterion                                                     | Maximum points |                 Group self-score | Evidence                                                                                                                                                              |
| ------------------------------------------------------------- | -------------: | -------------------------------: | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| All proposed screens present and navigable                    |              3 |                                3 | All eight proposed screen groups are implemented and reachable through the application's navigation and routes, including parameterized item detail and claim routes. |
| Feature-first structure; state in providers, not widgets      |              2 |                                2 | The application uses feature-specific domain, data and presentation layers, with application state managed through Riverpod providers.                                |
| Tests present; analyser and tests clean in the pasted output  |              1 |                                1 | The project has automated tests, and the final `flutter analyze --fatal-infos` and `flutter test` outputs pasted below show successful analysis and passing tests.    |
| Repository hygiene: branches, pull requests, readable history |              1 |                                1 | The group used separate development branches, reviewed pull requests before merging, and maintained a history of nine implementation pull requests.                   |
| Individual oral check (recorded per member)                   |              3 | 3 | Each member completed an individual oral check among themselves.                                                               |
7/7

## 5. One Thing We Will Change Before Milestone 2

Before Milestone 2, the group will replace the current in-memory repository implementations with persistent data storage while retaining the existing repository interfaces. This will allow application data, including reported items and claims, to remain available after the application is restarted.

## 6. Verification

The following commands are required for Milestone 1 and must be run on the final code state.

### Flutter analysis

**Command:**

```bash
flutter analyze --fatal-infos
```

**Complete output:**

```text
Analyzing campus_lost...
No issues found! (ran in 49.4s)
```

### Flutter tests

**Command:**

```bash
flutter test
```

**Complete output:**

```text
00:12 +66: All tests passed!
```

### Verification and tagging procedure

The verification outputs will be captured on the final application code state. The code state tested before the documentation commit will differ from the final tagged commit only by the documentation files `MILESTONE.md` and `AI_USAGE.md`.

After committing and merging the documentation PR, both commands will be run again to confirm that the results remain unchanged. The `m1` tag will be created and pushed only after the final documentation has been reviewed and merged and both verification commands have passed.
