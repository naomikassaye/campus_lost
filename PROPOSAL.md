# Project proposal

## 1. Title and one-sentence description

**CampusLost.** An app that helps Addis Ababa University students and staff to report, search and claim lost and found belongings so that items return to their owners quickly and safely.

## 2. Group

| Name | Role |
|---|---|
| Naomi Kassaye Tuffa | Project lead; architecture, state, navigation |
| Solyana Alemseged Zewdie | Camera feature, image handling, UI/UX |
| Maryamawit Lemma | Firebase: Auth, Firestore, Storage, security rules |
| Meron Mulugeta Mehari | REST integration, AI feature, local storage, testing |

IDs, emails and GitHub usernames: `project.yaml`.

## 3. The problem

**Who has it and how they cope today.** AAU students and staff on 4 Kilo, 5 Kilo (AAiT), 6 Kilo and the other campuses lose keys, ID cards, calculators and chargers every semester. They put notices on dormitory walls or post in Telegram channels. A wall notice reaches one building and is soon torn down. A Telegram post is buried within hours, cannot be filtered, and usually shows the owner's username or phone number.

**A real person.** Group member Naomi Kassaye Tuffa lost the keys to her dorm room and locker in her second year at AAU 4 Kilo. She posted notices in the dorms and on Telegram, but nobody replied, and maintenance had to break open her locker. Three months later she found the keys in the student lounge display.

**Why mobile.** A finder can post an item with a photo in under a minute, one post reaches every campus, and proof of ownership stays private.

## 4. Users

| User | Needs | Frequency |
|---|---|---|
| Seeker (lost something) | Search items, claim privately | Daily after a loss |
| Finder | Post found items, answer lost posts | 1-2 times a month |
| Custodian (guard, staff) | Confirm receipt, review claims | Daily |

## 5. User stories

1. As a user, I want to sign in with my university email so that my reports and claims are tied to me. (**must**)
2. As a finder, I want to post a found item with a photo, a suggested category and a handover point so that the owner can recognise it. (**must**)
3. As a seeker, I want to post a lost item with a description so that finders know what to look for. (**should**)
4. As a finder, I want to tap "I found this" on a lost post so that the owner sees a possible match. (**should**)
5. As a seeker, I want to search and filter found items and see where they are on a map so that I can tell if mine was found. (**must**)
6. As a seeker, I want to submit a private claim with proof and track it so that I can reclaim my item without publicly revealing details. (**must**)
7. As a custodian, I want to confirm receipt of an item, review claims and mark an item returned so that handovers are recorded. (**must**)
8. As a user on poor campus Wi-Fi, I want recent items cached and drafts saved so that I can browse and finish a report offline. (**must**)

**Item flow.** The finder hands the item to the handover point; the custodian confirms receipt (`held`), approves a claim, then marks it `returned`. "I found this" stores `matchedItemId` and shows the owner a "Possible match" badge.

## 6. Screens

| Screen | Purpose | Stories |
|---|---|---|
| Login / Register | Sign in or create an account | 1 |
| Profile & Settings | Sign out, theme, clear cache | 1, 8 |
| Feed (home) | Found / Lost toggle, search, filters | 3, 5, 8 |
| Item Details | Photo, map, status; Claim / I found this | 4-6 |
| Report Item | Found / Lost, camera, AI category, drafts | 2-4, 8 |
| Claim Form | Private proof of ownership | 6 |
| My Activity | My reports and claims, statuses, matches | 4, 6 |
| Review Claims (custodian) | Confirm receipt, review claims, mark returned | 7 |


```text
1. Feed                              2. Item Details
+--------------------------------+   +--------------------------------+
| CampusLost                (me) |   | <                              |
| [ Found | Lost ]               |   | [       item photo       ]     |
| [ Search items...        ]     |   | Dorm key set       [FOUND]     |
| [All][Keys][IDs]  [4 Kilo v]   |   | Place: Student lounge [Map]    |
| [img] Dorm key set, 2h         |   | Status: Open                   |
| (Feed)    [ + ]  (Activity)    |   | [ Claim this item ]            |
|                                |   | (lost post: [I found this])    |
+--------------------------------+   +--------------------------------+

3. Report Item                       4. My Activity
+--------------------------------+   +--------------------------------+
| X Cancel         Report item   |   | My Activity                    |
| [ Found | Lost ]               |   | [My reports]  [My claims]      |
| [ camera: take a photo   ]     |   | Dorm key set                   |
| Suggested: Keys     [Use]      |   |   [PENDING REVIEW]             |
| Title:    [____________]       |   |   Proof: red keyring           |
| Category: [Keys       v]       |   | Blue ID          [APPROVED]    |
| Place:    [4 Kilo v][______]   |   | (Feed)    [ + ]  (Activity)    |
| Handover: [Guard desk v]       |   |                                |
| [ Save draft ]  [ Submit ]     |   |                                |
+--------------------------------+   +--------------------------------+
```

## 7. Data model

Relationships: User 1-N ItemReport and ClaimRequest; ItemReport 1-N ClaimRequest; CampusLocation 1-N ItemReport; a found report may point to a lost one (`matchedItemId`).

```text
User:          id (Auth UID), fullName, email, createdAt
               (custodian = Auth custom claim set by an admin, not writable by clients)
ItemReport:    id, reporterId, type (lost|found), title, description, category,
               campusLocationId, placeDetail, latitude, longitude, photoUrl, aiLabels,
               matchedItemId (optional), status (open|held|claimed|returned), createdAt
ClaimRequest:  id, itemId, claimantId, proofText (claimant and custodians only),
               status (pending|approved|rejected), createdAt, decidedBy
CampusLocation: id, campusName, buildingName, handoverPoint, latitude, longitude
```

## 8. Data sources

- **Local:** `drift` (50 latest items, drafts); `shared_preferences`.
- **REST:** OpenStreetMap Nominatim: map link for a place (story 5).
- **Firebase:** Auth, Cloud Firestore (items, claims, users), Storage (photos).

## 9. Device feature and AI feature

**Device: camera (story 2).** `image_picker`. Permissions: Android `CAMERA`; iOS `NSCameraUsageDescription`, `NSPhotoLibraryUsageDescription`.

**AI: image labelling (story 2).** Google ML Kit runs on the device, so no photo is sent to any server; only labels are saved and mapped to our categories.

## 10. Risks

| Risk | Likelihood | Plan |
|---|---|---|
| R1 Fraudulent claims | Medium | Private proof, approval |
| R2 Poor connectivity | High | Cache, drafts, retry |
| R3 Service limits | Medium | Check now; Firestore fallback |
| R4 Member unavailable | Medium | Check-ins; cut stories 3, 4 |

## 11. Milestone plan

- **Milestone 1 (week 6):** All eight screens with navigation and Riverpod in-memory state on mock data. Firebase project created and Storage plan checked.
- **Milestone 2 (week 10):** Real data. Stories 1, 2 (camera, photo upload, manual category), 5, 6 and 7 complete, with security rules. Story 8 cache started.
- **Final (week 14):** Story 2 ML Kit suggestion, story 8 drafts, stories 3 and 4, tests, polish, demo.

## 12. AI-use plan

We will use Claude and Gemini to explain concepts, debug and draft tests, and an editor assistant for boilerplate. Every member must be able to explain the code they commit; we log significant AI uses.
