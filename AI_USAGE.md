# AI Usage Disclosure

## Tools Used

| **Tool** | **Version / model** | **Used for** |
|---|---|---|
| Claude | Sonnet 5.5 | Reviewing implementation, explaining Freezed models and assisting with code understanding. |
| ChatGPT | GPT-6 | Code review, Git troubleshooting, implementation guidance, and code understanding |

Claude was used by all four group members. ChatGPT was used by Naomi and Meron.

## What Was Generated and Where

| **File / function** | **Member** | **AI-use level** | **What the tool produced** | **What we changed** | **How we verified it** |
|---|---|---|---|---|---|
| Item and claim models, repository interfaces, in-memory repositories, providers and tests (PR #4) | Naomi | 2 | AI-assisted implementation suggestions, code drafts and explanations for the data layer and tests | Reviewed and adapted the suggestions and corrected implementation details | Reviewed the code, ran Flutter analysis and tests |
| Navigation shell, router redirects and My Activity (PR #8) | Naomi | 2 | AI-assisted implementation suggestions and explanations for navigation, routing and tests | Reviewed the suggestions and made implementation decisions based on the project requirements and role-based navigation requirements | Reviewed the implementation, ran tests and manually checked the application in Chrome |
| Report Item and feed integration (PRs #2 and #7) | Solyana | 2 | Claude assisted with implementation review and explanations of Freezed models | Reviewed the suggestions and made implementation decisions based on the project requirements | Reviewed the code and tested the relevant application flow |
| Feed item details and claim form (PR #6) | Meron | 2 | Claude assisted with implementation review. ChatGPT was also used for assistance | Reviewed and adapted the suggestions to the existing project implementation | Reviewed the code and tested the relevant application flow |
| Authentication, profile/settings and Review Claims (PRs #3, #5 and #9) | Maryamawit | 2 | Claude assisted with implementation review. | Reviewed the suggestions | Reviewed the code and tested the relevant application flows |

## Which Tasks Did We Do Without an Assistant First?

The group made the project decisions and agreed on the application features, screen structure, responsibilities and implementation plan. Members worked on their assigned features and made implementation decisions before using AI for explanations, suggestions, implementation assistance or code reviews.

AI assistance was used as a supporting tool throughout development. Members remained responsible for understanding the implementation, reviewing and adapting suggestions, and verifying the resulting code.

## Problems Found in AI Output

- An initial AI suggestion treated the item category as a `String`. The implementation was corrected to use the `ItemCategory` enum already established in the project.
- An initial My Activity suggestion used `.value ?? []` instead of handling the Riverpod `AsyncValue` with the `when` pattern. The implementation was corrected after checking the course material.

## Individual Declaration

Each member should review their file list and complete their own declaration.

| **Name** | **I wrote or reviewed and can explain these files** | **I entered no passwords, keys or personal data into an AI tool (yes / no)** | **Signature** |
|---|---|---|---|
| Naomi Kassaye Tuffa | `lib/app.dart`, `lib/core/theme/app_theme.dart`, `lib/core/router/app_router.dart`, `lib/core/widgets/app_shell.dart`, `lib/core/widgets/placeholder_page.dart`, `lib/features/auth/data/auth_providers.dart`, `lib/features/item_details/`, `lib/features/claim/`, `lib/features/my_activity/`, `lib/features/report_item/`, and related repository, model, provider and test files. | No | Naomi Kassaye |
| Solyana Alemseged Zewdie | `lib/features/report_item/`, `lib/features/feed/`, and related report-item and feed integration files and tests. | No | Solyana Alemseged |
| Meron Mulugeta Mehari | `lib/features/feed/`, `lib/features/item_details/`, `lib/features/claim/`, and related feed, item-detail and claim-flow files and tests. | No | Meron Mulugeta |
| Maryamawit Lemma | `lib/features/auth/`, `lib/features/profile/`, `lib/features/review_claims/`, and related authentication, profile/settings and review-claims files and tests. | No | Maryamawit Lemma |

**Date:** 27 November 2026