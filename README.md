# Comprehensive Practical Lab Submission: Dart & Flutter

**Student Name:** Vadgama Priya Ashokbhai  
**Roll Number:** 35  
**Enrollment No:** 240801617  
**Admission No:** 15612424037  
**College:** Faculty of Science, Atmiya University, Rajkot  
**Department:** C.S. & I.T.  
**Course:** B.C.A. (Semester 5, Division C11)  
**Institutional Email:** 15612424037@atmiyauni.edu.in  
**Course Subject:** Mobile Application Development (Flutter & Dart)  
**Verification:** All Dart programs run with 0 errors; Flutter app passes `flutter analyze` with 0 errors & 0 warnings.

---

## 📑 Master Table of Contents

1. [Project Directory Architecture](#-project-directory-architecture)
2. [Module I: Pure Dart Programming (Practicals 1 to 30)](#-module-i-pure-dart-programming-practicals-1-to-30)
3. [Module II: Flutter UI Practicals (Sections A, B & C)](#-module-ii-flutter-ui-practicals-sections-a-b--c)
   - [Section A: Easy Level UI Practicals (1 to 10)](#-section-a-easy-level-ui-practicals-1-to-10)
   - [Section B: Moderate Level UI Practicals (1 to 10)](#-section-b-moderate-level-ui-practicals-1-to-10)
   - [Section C: Hard Level UI Practicals (1 to 10)](#-section-c-hard-level-ui-practicals-1-to-10)
4. [Module III: State Management & Navigation Practicals](#-module-iii-state-management--navigation-practicals)
   - [Easy Level (1 to 10)](#easy-level-state-management--navigation)
   - [Moderate Level (1 to 10)](#moderate-level-state-management--forms)
   - [Hard Level (1 to 10)](#hard-level-bloc-riverpod-provider-wizards)
5. [Module IV: Data Persistence & Caching](#-module-iv-data-persistence--caching)
   - [Level 1 - Easy Suite (Q1 to Q10)](#module-iv-level-1-easy-suite)
   - [Level 2 - Moderate Suite (Q1 to Q10)](#module-iv-level-2-moderate-suite)
   - [Level 3 - Hard Suite (Q1 to Q10)](#module-iv-level-3-hard-suite)
6. [Module V: Data Persistence using SharedPreferences, SQLite & Hive (10 Tasks)](#-module-v-data-persistence-sharedpreferences-sqlite--hive)
7. [How to Run & Verify](#-how-to-run--verify)

---

## 📁 Project Directory Architecture

```text

├── README.md                              # Master lab report and index
│
├── dart_practicals/                       # Pure Dart CLI Programs (Q1 to Q30)
│   ├── q01_variables_interpolation.dart   # Q1: var, final, const & String interpolation
│   ├── q02_grading_system.dart            # Q2: Exam percentage & if-else grading
│   ├── q03_weekday_switch.dart            # Q3: Weekly routine via switch statement
│   ├── q04_multiplication_table.dart      # Q4: For loop table of roll digit (1)
│   ├── q05_even_numbers_while.dart        # Q5: While loop even numbers up to roll (35)
│   ├── q06_simple_interest.dart           # Q6: calculateSimpleInterest(P, R, T)
│   ├── q07_optional_positional_birthday.dart # Q7: Optional positional parameters
│   ├── q08_named_parameters_marks.dart    # Q8: Named parameters for 4+ semester marks
│   ├── q09_arrow_function_circle_area.dart# Q9: Fat arrow (=>) circle area calculation
│   ├── q10_anonymous_foreach_name.dart    # Q10: Anonymous function in forEach for name
│   ├── q11_list_operations_movies.dart    # Q11: List add, remove, and sort operations
│   ├── q12_map_where_grace_marks.dart     # Q12: List map() grace marks & where() filter
│   ├── q13_set_operations.dart            # Q13: Sets union, intersection & difference
│   ├── q14_timetable_map.dart             # Q14: Weekly Timetable Map with forEach
│   ├── q15_friends_colors.dart            # Q15: Map putIfAbsent demonstration
│   ├── q16_nullable_career_goal.dart      # Q16: Null safety operators (?? and ??=)
│   ├── q17_late_college_name.dart         # Q17: late keyword initialization
│   ├── q18_try_catch_division.dart        # Q18: Try-catch division by zero with roll no
│   ├── q19_multiple_on_clauses.dart       # Q19: Multiple 'on' exception clauses
│   ├── q20_custom_exception_attendance.dart# Q20: LowAttendanceException (<75%)
│   ├── q21_student_class.dart             # Q21: Student class with marks, avg & grade
│   ├── q22_book_constructors.dart         # Q22: Book class default & named constructors
│   ├── q23_inheritance_person_teacher.dart# Q23: Person -> Teacher inheritance & override
│   ├── q24_abstract_shape.dart            # Q24: Abstract Shape (Square & RightTriangle)
│   ├── q25_interfaces_photo.dart          # Q25: Drawable & Resizable implemented by Photo
│   ├── q26_mixins_skills.dart             # Q26: Coding, Drawing, Cooking mixins on MySkills
│   ├── q27_mixin_on_account.dart          # Q27: Mixin with 'on' constraint on Account
│   ├── q28_async_then_college.dart        # Q28: Future.delayed & .then() callback
│   ├── q29_async_await_sequence.dart      # Q29: Sequential async/await fetch pipeline
│   └── q30_stream_multiplication.dart     # Q30: Dart Stream with async* & await for
│
└── flutter_practicals/                    # Master Flutter Application
    ├── pubspec.yaml                       # Dependencies: Provider, Riverpod, BLoC, SQLite, Hive, etc.
    └── lib/
        ├── main.dart                      # 8-Tab Interactive Lab Showcase Dashboard
        │
        ├── section_a/                     # Section A: Easy Level UI (10 Practicals)
        │   ├── q01_stateless_student_info.dart
        │   ├── q02_counter_stateful.dart
        │   ├── q03_scaffold_appbar_fab.dart
        │   ├── q04_listview_fruits.dart
        │   ├── q05_gridview_colored_boxes.dart
        │   ├── q06_card_widget_image_desc.dart
        │   ├── q07_drawer_navigation.dart
        │   ├── q08_bottom_navigation_bar.dart
        │   ├── q09_stack_text_container.dart
        │   └── q10_custom_section_title.dart
        │
        ├── section_b/                     # Section B: Moderate Level UI (10 Practicals)
        │   ├── q01_stateful_lifecycle_demo.dart
        │   ├── q02_responsive_column_row.dart
        │   ├── q03_product_grid_card.dart
        │   ├── q04_profile_card_widget.dart
        │   ├── q05_skill_tag_wrap_chips.dart
        │   ├── q06_badge_icon_stack.dart
        │   ├── q07_tabbar_media_views.dart
        │   ├── q08_settings_table_widget.dart
        │   ├── q09_adaptive_form_layout.dart
        │   └── q10_custom_expansion_accordion.dart
        │
        ├── section_c/                     # Section C: Hard Level UI (10 Practicals)
        │   ├── q01_responsive_dashboard.dart
        │   ├── q02_custom_widget_library.dart
        │   ├── q03_product_detail_screen.dart
        │   ├── q04_todo_didupdatewidget.dart
        │   ├── q05_responsive_nav_shell.dart
        │   ├── q06_profile_tabs_grid_list.dart
        │   ├── q07_intrinsic_height_news_feed.dart
        │   ├── q08_overlapping_profile_header.dart
        │   ├── q09_reflowing_settings_screen.dart
        │   └── q10_widget_lifecycle_logger.dart
        │
        ├── easy/                          # Module III State Management: Easy (10 Practicals)
        │   ├── q01_listview_names.dart
        │   ├── q02_listtile_icon_text.dart
        │   ├── q03_gridview_colors.dart
        │   ├── q04_navigation_push_pop.dart
        │   ├── q05_named_routes.dart
        │   ├── q06_simple_form_validation.dart
        │   ├── q07_counter_setstate.dart
        │   ├── q08_checkbox_setstate.dart
        │   ├── q09_counter_changenotifier.dart
        │   └── q10_read_vs_watch.dart
        │
        ├── moderate/                      # Module III State Management: Moderate (10 Practicals)
        │   ├── q01_product_catalog_grid.dart
        │   ├── q02_search_filter_listview.dart
        │   ├── q03_pass_student_object.dart
        │   ├── q04_pop_data_snackbar.dart
        │   ├── q05_registration_form_validation.dart
        │   ├── q06_login_form_credentials.dart
        │   ├── q07_todo_list_setstate.dart
        │   ├── q08_shopping_cart_provider.dart
        │   ├── q09_star_rating_widget.dart
        │   └── q10_star_pattern_screen.dart
        │
        ├── hard/                          # Module III State Management: Hard (10 Practicals)
        │   ├── q01_form_wizard_navigation.dart
        │   ├── q02_mini_ecommerce_provider.dart
        │   ├── q03_todo_riverpod.dart
        │   ├── q04_counter_bloc.dart
        │   ├── q05_toggle_list_grid.dart
        │   ├── q06_complex_form_summary.dart
        │   ├── q07_theme_switcher_provider.dart
        │   ├── q08_number_pyramid.dart
        │   ├── q09_nested_navigation_indexedstack.dart
        │   └── q10_multi_user_login_provider.dart
        │
        ├── module_iv/                     # Module IV: Data Persistence & Caching
        │   ├── module_iv_easy.dart        # Easy Suite (Q1 to Q10)
        │   ├── module_iv_moderate.dart    # Moderate Suite (Q1 to Q10)
        │   └── module_iv_hard.dart        # Hard Suite (Q1 to Q10)
        │
        └── module_v/                      # Module V: DB & Persistence (10 Practicals)
            ├── q01_pref_save_username.dart
            ├── q02_pref_dark_mode.dart
            ├── q03_sqlite_products_table.dart
            ├── q04_sqlite_insert_student.dart
            ├── q05_sqlite_listview_display.dart
            ├── q06_sqlite_update_record.dart
            ├── q07_sqlite_delete_record.dart
            ├── q08_hive_simple_todo.dart
            ├── q09_hive_user_name_age.dart
            └── q10_file_storage_path_provider.dart
```

---

## 🎯 Module I: Pure Dart Programming (Practicals 1 to 30)

| No. | File Name | Core Concept Demonstrated | Sample Output Summary |
|:---:|:---|:---|:---|
| **Q1** | [`q01_variables_interpolation.dart`](dart_practicals/q01_variables_interpolation.dart) | `var`, `final`, `const`, String Interpolation | `Hi, I am Vadgama Priya Ashokbhai (Roll No: 35) from Rajkot.` |
| **Q2** | [`q02_grading_system.dart`](dart_practicals/q02_grading_system.dart) | Percentage grading with `if-else` | `Percentage: 88.5% -> Grade: A (First Class with Distinction)` |
| **Q3** | [`q03_weekday_switch.dart`](dart_practicals/q03_weekday_switch.dart) | Weekly schedule via `switch` | Daily routine starting Monday through Sunday |
| **Q4** | [`q04_multiplication_table.dart`](dart_practicals/q04_multiplication_table.dart) | `for` loop multiplication table | Table of last digit of roll (35 % 10 = 5): `5 x 1 = 5 ... 5 x 10 = 50` |
| **Q5** | [`q05_even_numbers_while.dart`](dart_practicals/q05_even_numbers_while.dart) | `while` loop even numbers | Even numbers 1 to 35: `2, 4, 6, 8, 10, ..., 34` (17 numbers) |
| **Q6** | [`q06_simple_interest.dart`](dart_practicals/q06_simple_interest.dart) | Mathematical function `(P*R*T)/100` | 3 test cases evaluated with formatted interest & totals |
| **Q7** | [`q07_optional_positional_birthday.dart`](dart_practicals/q07_optional_positional_birthday.dart) | Optional positional parameters `[name, age]` | Defaults to `'Priya'`, `20`; tested with 4 overrides |
| **Q8** | [`q08_named_parameters_marks.dart`](dart_practicals/q08_named_parameters_marks.dart) | Named parameters with `required` | 5 Semester V subject marks computed with average & result |
| **Q9** | [`q09_arrow_function_circle_area.dart`](dart_practicals/q09_arrow_function_circle_area.dart) | Arrow function `=> pi * r * r` | Areas calculated for radii 3.5, 7.0, and 14.2 cm |
| **Q10** | [`q10_anonymous_foreach_name.dart`](dart_practicals/q10_anonymous_foreach_name.dart) | Anonymous lambda inside `forEach` | Prints characters `P`, `r`, `i`, `y`, `a` on individual lines |
| **Q11** | [`q11_list_operations_movies.dart`](dart_practicals/q11_list_operations_movies.dart) | `List` methods: `add`, `remove`, `sort` | Movie list modified and printed after each step |
| **Q12** | [`q12_map_where_grace_marks.dart`](dart_practicals/q12_map_where_grace_marks.dart) | `map()` + 5 grace & `where()` filter | Adds 5 marks to 6 subjects and separates passing (>=50) |
| **Q13** | [`q13_set_operations.dart`](dart_practicals/q13_set_operations.dart) | Set `union`, `intersection`, `difference` | Demonstrates set theory on unique personal & friend hobbies |
| **Q14** | [`q14_timetable_map.dart`](dart_practicals/q14_timetable_map.dart) | Map iteration with `forEach` | `Monday: MAD`, `Tuesday: CC`, `Wednesday: AI/ML`, etc. |
| **Q15** | [`q15_friends_colors.dart`](dart_practicals/q15_friends_colors.dart) | Map `putIfAbsent` | Adds student self with favourite colour without overwriting |
| **Q16** | [`q16_nullable_career_goal.dart`](dart_practicals/q16_nullable_career_goal.dart) | Null coalescing `??` and `??=` | Handles initially null career aspiration with fallbacks |
| **Q17** | [`q17_late_college_name.dart`](dart_practicals/q17_late_college_name.dart) | `late` keyword deferred initialization | Top-level variable initialized inside a dedicated function |
| **Q18** | [`q18_try_catch_division.dart`](dart_practicals/q18_try_catch_division.dart) | Exception handling `try-catch` | Deliberate division by zero with custom student roll message |
| **Q19** | [`q19_multiple_on_clauses.dart`](dart_practicals/q19_multiple_on_clauses.dart) | Multiple `on FormatException`, `RangeError` | Handles string parsing error and index out-of-range separately |
| **Q20** | [`q20_custom_exception_attendance.dart`](dart_practicals/q20_custom_exception_attendance.dart) | Custom exception `implements Exception` | Throws `LowAttendanceException` when attendance drops below 75% |
| **Q21** | [`q21_student_class.dart`](dart_practicals/q21_student_class.dart) | OOP Class, Constructor & Methods | Encapsulates student credentials and computes final grade |
| **Q22** | [`q22_book_constructors.dart`](dart_practicals/q22_book_constructors.dart) | Named & Default Constructors | Demonstrates default book title and custom book configuration |
| **Q23** | [`q23_inheritance_person_teacher.dart`](dart_practicals/q23_inheritance_person_teacher.dart) | Class Inheritance (`extends`) & `@override` | `Teacher extends Person`, overrides `displayRole()` |
| **Q24** | [`q24_abstract_shape.dart`](dart_practicals/q24_abstract_shape.dart) | Abstract Class & Polymorphism | `Square` and `RightTriangle` implementing `area()` & `perimeter()` |
| **Q25** | [`q25_interfaces_photo.dart`](dart_practicals/q25_interfaces_photo.dart) | Multiple Interfaces (`implements`) | `Photo implements Drawable, Resizable` with resolution scaling |
| **Q26** | [`q26_mixins_skills.dart`](dart_practicals/q26_mixins_skills.dart) | Multi-Mixin Composition (`with`) | `MySkills with Coding, Drawing, Cooking` invoked in `main()` |
| **Q27** | [`q27_mixin_on_account.dart`](dart_practicals/q27_mixin_on_account.dart) | Mixin `on` constraint | `InterestCalculator on Account` computes 5% interest on balance |
| **Q28** | [`q28_async_then_college.dart`](dart_practicals/q28_async_then_college.dart) | `Future.delayed` & `.then()` callback | Non-blocking execution prints immediately before 2s delay |
| **Q29** | [`q29_async_await_sequence.dart`](dart_practicals/q29_async_await_sequence.dart) | Sequential `async/await` execution | Fetches Name -> Roll -> Result in 1s intervals with timestamps |
| **Q30** | [`q30_stream_multiplication.dart`](dart_practicals/q30_stream_multiplication.dart) | Dart `Stream` with `async*` & `await for` | Emits `roll (35) * multiplier (1..5)` at 1-second intervals |

---

## 📱 Module II: Flutter UI Practicals (Sections A, B & C)

### 🎨 Section A: Easy Level UI Practicals (1 to 10)

| Practical | File Path | Description |
|:---:|:---|:---|
| **A1** | [`section_a/q01_stateless_student_info.dart`](flutter_practicals/lib/section_a/q01_stateless_student_info.dart) | `StatelessWidget` displaying name, college name, and course in 3 Text widgets in a Column. |
| **A2** | [`section_a/q02_counter_stateful.dart`](flutter_practicals/lib/section_a/q02_counter_stateful.dart) | Counter application built with `StatefulWidget` having Increment and Decrement actions. |
| **A3** | [`section_a/q03_scaffold_appbar_fab.dart`](flutter_practicals/lib/section_a/q03_scaffold_appbar_fab.dart) | Standard `Scaffold` architecture featuring top `AppBar`, body `Text`, and interactive FAB. |
| **A4** | [`section_a/q04_listview_fruits.dart`](flutter_practicals/lib/section_a/q04_listview_fruits.dart) | `ListView.builder` displaying 12 fruits with caloric information and customized leading icons. |
| **A5** | [`section_a/q05_gridview_colored_boxes.dart`](flutter_practicals/lib/section_a/q05_gridview_colored_boxes.dart) | `GridView.count` displaying 6 material coloured cards with 2 items per row. |
| **A6** | [`section_a/q06_card_widget_image_desc.dart`](flutter_practicals/lib/section_a/q06_card_widget_image_desc.dart) | `Card` widget containing styled graphical representation, title, and project description. |
| **A7** | [`section_a/q07_drawer_navigation.dart`](flutter_practicals/lib/section_a/q07_drawer_navigation.dart) | Side navigation `Drawer` featuring a user header and 5 destination `ListTile` options. |
| **A8** | [`section_a/q08_bottom_navigation_bar.dart`](flutter_practicals/lib/section_a/q08_bottom_navigation_bar.dart) | `BottomNavigationBar` switching between Home, Search, and Profile views. |
| **A9** | [`section_a/q09_stack_text_container.dart`](flutter_practicals/lib/section_a/q09_stack_text_container.dart) | `Stack` layering text label and status badge on top of a styled container. |
| **A10** | [`section_a/q10_custom_section_title.dart`](flutter_practicals/lib/section_a/q10_custom_section_title.dart) | Custom reusable `SectionTitle` widget utilized across Academics and Settings screens. |

---

### 🛠️ Section B: Moderate Level UI Practicals (1 to 10)

| Practical | File Path | Description |
|:---:|:---|:---|
| **B1** | [`section_b/q01_stateful_lifecycle_demo.dart`](flutter_practicals/lib/section_b/q01_stateful_lifecycle_demo.dart) | Logs all lifecycle stages (`initState`, `didChangeDependencies`, `build`, `dispose`) to console. |
| **B2** | [`section_b/q02_responsive_column_row.dart`](flutter_practicals/lib/section_b/q02_responsive_column_row.dart) | `LayoutBuilder` responsive layout rendering `Column` on mobile and `Row` on desktop/tablet. |
| **B3** | [`section_b/q03_product_grid_card.dart`](flutter_practicals/lib/section_b/q03_product_grid_card.dart) | `GridView.builder` catalog with product image placeholder, name, and formatted price. |
| **B4** | [`section_b/q04_profile_card_widget.dart`](flutter_practicals/lib/section_b/q04_profile_card_widget.dart) | Custom `ProfileCard` widget instantiated 3 times with custom avatars, data, and callbacks. |
| **B5** | [`section_b/q05_skill_tag_wrap_chips.dart`](flutter_practicals/lib/section_b/q05_skill_tag_wrap_chips.dart) | `Wrap` widget containing interactive `FilterChip` items toggling selected skills. |
| **B6** | [`section_b/q06_badge_icon_stack.dart`](flutter_practicals/lib/section_b/q06_badge_icon_stack.dart) | Notification badge counter positioned on top of icons using `Stack` and `Positioned`. |
| **B7** | [`section_b/q07_tabbar_media_views.dart`](flutter_practicals/lib/section_b/q07_tabbar_media_views.dart) | `TabBar` with Photos, Videos, and Files tabs showing distinct interactive viewports. |
| **B8** | [`section_b/q08_settings_table_widget.dart`](flutter_practicals/lib/section_b/q08_settings_table_widget.dart) | System configuration settings rendered with aligned rows and columns using `Table`. |
| **B9** | [`section_b/q09_adaptive_form_layout.dart`](flutter_practicals/lib/section_b/q09_adaptive_form_layout.dart) | Form adapting between single column (mobile) and two columns side-by-side (tablet/desktop) via `MediaQuery`. |
| **B10** | [`section_b/q10_custom_expansion_accordion.dart`](flutter_practicals/lib/section_b/q10_custom_expansion_accordion.dart) | Interactive `ExpansionTile` FAQ accordion demonstrating collapsible animated cards. |

---

### 🏗️ Section C: Hard Level UI Practicals (1 to 10)

| Practical | File Path | Description |
|:---:|:---|:---|
| **C1** | [`section_c/q01_responsive_dashboard.dart`](flutter_practicals/lib/section_c/q01_responsive_dashboard.dart) | 3-tier responsive dashboard: 1-col mobile, 2-col tablet, 3-panel row on desktop. |
| **C2** | [`section_c/q02_custom_widget_library.dart`](flutter_practicals/lib/section_c/q02_custom_widget_library.dart) | Reusable component library (`CustomButton`, `CustomCard`, `CustomAppBar`) on demo screen. |
| **C3** | [`section_c/q03_product_detail_screen.dart`](flutter_practicals/lib/section_c/q03_product_detail_screen.dart) | E-commerce layout: `Stack` badge, `Wrap` tags, and `Flexible` bottom purchase bar. |
| **C4** | [`section_c/q04_todo_didupdatewidget.dart`](flutter_practicals/lib/section_c/q04_todo_didupdatewidget.dart) | To-do app leveraging `didUpdateWidget` for reactive state synchronisation with parent. |
| **C5** | [`section_c/q05_responsive_nav_shell.dart`](flutter_practicals/lib/section_c/q05_responsive_nav_shell.dart) | Adaptive shell automatically switching between `Drawer` (mobile) and `NavigationRail` (desktop). |
| **C6** | [`section_c/q06_profile_tabs_grid_list.dart`](flutter_practicals/lib/section_c/q06_profile_tabs_grid_list.dart) | Combined profile screen with `TabBar`, `GridView` photo gallery, and `ListView` activity feed. |
| **C7** | [`section_c/q07_intrinsic_height_news_feed.dart`](flutter_practicals/lib/section_c/q07_intrinsic_height_news_feed.dart) | Feed using `IntrinsicHeight` to dynamically match thumbnail image and multiline article text height. |
| **C8** | [`section_c/q08_overlapping_profile_header.dart`](flutter_practicals/lib/section_c/q08_overlapping_profile_header.dart) | `Stack` & `Positioned` profile header where circular avatar overlaps banner lower edge. |
| **C9** | [`section_c/q09_reflowing_settings_screen.dart`](flutter_practicals/lib/section_c/q09_reflowing_settings_screen.dart) | Grouped settings layout reflowing from 1 column into 2 columns when width exceeds 700dp. |
| **C10** | [`section_c/q10_widget_lifecycle_logger.dart`](flutter_practicals/lib/section_c/q10_widget_lifecycle_logger.dart) | Generic wrapper `StatefulWidget` logging all lifecycle events with timestamped telemetry. |

---

## ⚡ Module III: State Management & Navigation Practicals

### Easy Level (State Management & Navigation)
- [`easy/q01_listview_names.dart`](flutter_practicals/lib/easy/q01_listview_names.dart): Displaying 10 names with `ListView.builder`.
- [`easy/q02_listtile_icon_text.dart`](flutter_practicals/lib/easy/q02_listtile_icon_text.dart): `ListTile` with custom leading icons and subtitles.
- [`easy/q03_gridview_colors.dart`](flutter_practicals/lib/easy/q03_gridview_colors.dart): 6 coloured cards in a 2-column grid.
- [`easy/q04_navigation_push_pop.dart`](flutter_practicals/lib/easy/q04_navigation_push_pop.dart): Parameterized `Navigator.push` and `pop`.
- [`easy/q05_named_routes.dart`](flutter_practicals/lib/easy/q05_named_routes.dart): Named routes table (`/`, `/about`, `/contact`).
- [`easy/q06_simple_form_validation.dart`](flutter_practicals/lib/easy/q06_simple_form_validation.dart): Validates required non-empty text input.
- [`easy/q07_counter_setstate.dart`](flutter_practicals/lib/easy/q07_counter_setstate.dart): Local reactive counter using `setState()`.
- [`easy/q08_checkbox_setstate.dart`](flutter_practicals/lib/easy/q08_checkbox_setstate.dart): Interactive `Checkbox` updating status text.
- [`easy/q09_counter_changenotifier.dart`](flutter_practicals/lib/easy/q09_counter_changenotifier.dart): `ChangeNotifier` counter with `Consumer`.
- [`easy/q10_read_vs_watch.dart`](flutter_practicals/lib/easy/q10_read_vs_watch.dart): Clear architectural contrast between `context.read()` and `context.watch()`.

### Moderate Level (State Management & Forms)
- [`moderate/q01_product_catalog_grid.dart`](flutter_practicals/lib/moderate/q01_product_catalog_grid.dart): 3-column responsive product catalog.
- [`moderate/q02_search_filter_listview.dart`](flutter_practicals/lib/moderate/q02_search_filter_listview.dart): Real-time live search query filtering on records.
- [`moderate/q03_pass_student_object.dart`](flutter_practicals/lib/moderate/q03_pass_student_object.dart): Strongly-typed `Student` object passing through router.
- [`moderate/q04_pop_data_snackbar.dart`](flutter_practicals/lib/moderate/q04_pop_data_snackbar.dart): Receiving data back via `Navigator.pop(context, data)` into a `SnackBar`.
- [`moderate/q05_registration_form_validation.dart`](flutter_practicals/lib/moderate/q05_registration_form_validation.dart): Regex email validation and password length checks.
- [`moderate/q06_login_form_credentials.dart`](flutter_practicals/lib/moderate/q06_login_form_credentials.dart): Credential authentication with error banners and navigation.
- [`moderate/q07_todo_list_setstate.dart`](flutter_practicals/lib/moderate/q07_todo_list_setstate.dart): Add, complete, and delete to-do tasks with animation.
- [`moderate/q08_shopping_cart_provider.dart`](flutter_practicals/lib/moderate/q08_shopping_cart_provider.dart): Shopping cart using `Provider` with automatic total calculation.
- [`moderate/q09_star_rating_widget.dart`](flutter_practicals/lib/moderate/q09_star_rating_widget.dart): Interactive 1 to 5 star rating component.
- [`moderate/q10_star_pattern_screen.dart`](flutter_practicals/lib/moderate/q10_star_pattern_screen.dart): Dynamic star pattern generator based on user input N.

### Hard Level (BLoC, Riverpod, Provider, Wizards)
- [`hard/q01_form_wizard_navigation.dart`](flutter_practicals/lib/hard/q01_form_wizard_navigation.dart): 3-step form wizard (Personal -> Address -> Review).
- [`hard/q02_mini_ecommerce_provider.dart`](flutter_practicals/lib/hard/q02_mini_ecommerce_provider.dart): Multi-screen mini e-commerce pipeline using `Provider`.
- [`hard/q03_todo_riverpod.dart`](flutter_practicals/lib/hard/q03_todo_riverpod.dart): State management with Flutter Riverpod `StateNotifierProvider`.
- [`hard/q04_counter_bloc.dart`](flutter_practicals/lib/hard/q04_counter_bloc.dart): BLoC architecture (`flutter_bloc`) with events and streams.
- [`hard/q05_toggle_list_grid.dart`](flutter_practicals/lib/hard/q05_toggle_list_grid.dart): Instant view toggle between `ListView` and `GridView` preserving items.
- [`hard/q06_complex_form_summary.dart`](flutter_practicals/lib/hard/q06_complex_form_summary.dart): Complex form combining Dropdown, Checkbox, TextFormFields with `Form.save`.
- [`hard/q07_theme_switcher_provider.dart`](flutter_practicals/lib/hard/q07_theme_switcher_provider.dart): Global dark/light theme switcher using `Provider`.
- [`hard/q08_number_pyramid.dart`](flutter_practicals/lib/hard/q08_number_pyramid.dart): Dynamic pyramid number generation based on user input.
- [`hard/q09_nested_navigation_indexedstack.dart`](flutter_practicals/lib/hard/q09_nested_navigation_indexedstack.dart): Independent nested navigation stacks per tab using `IndexedStack`.
- [`hard/q10_multi_user_login_provider.dart`](flutter_practicals/lib/hard/q10_multi_user_login_provider.dart): Multi-user authentication validating against a `Provider` user directory.

---

## 💾 Module IV: Data Persistence & Caching

### Module IV: Level 1 - Easy Suite
- **File:** [`lib/module_iv/module_iv_easy.dart`](flutter_practicals/lib/module_iv/module_iv_easy.dart)
- **Features Demonstrated:**
  1. Print path from `getApplicationDocumentsDirectory()`.
  2. Write string to file with `writeAsString()`.
  3. Read file with `readAsString()` and display in UI.
  4. Verify `exists()` before file access.
  5. Delete file via `file.delete()` with confirmation.
  6. Persist String in `SharedPreferences`.
  7. Persist and increment integer counter in `SharedPreferences`.
  8. In-memory caching using a Dart `Map` for API responses.
  9. Convert Dart Map to JSON with `jsonEncode()`.
  10. Parse JSON string to Map with `jsonDecode()`.

### Module IV: Level 2 - Moderate Suite
- **File:** [`lib/module_iv/module_iv_moderate.dart`](flutter_practicals/lib/module_iv/module_iv_moderate.dart)
- **Features Demonstrated:**
  1. Notes file persistence (save and load).
  2. `StudentModel` class with bidirectional `toJson()` and `fromJson()` tests.
  3. `List<String>` stored and retrieved from `SharedPreferences`.
  4. Cache-first data loader checking memory before network calls.
  5. "Clear Cache" button resetting memory cache for fresh fetches.
  6. Theme preference (dark/light) persisted across app launches.
  7. Append new text to an existing file (`FileMode.append`).
  8. `List<StudentModel>` serialized to JSON file on disk.
  9. File copying into the app documents directory.
  10. Offline submission queue saving unsent form data in `SharedPreferences`.

### Module IV: Level 3 - Hard Suite
- **File:** [`lib/module_iv/module_iv_hard.dart`](flutter_practicals/lib/module_iv/module_iv_hard.dart)
- **Features Demonstrated:**
  1. Full Notes CRUD stored in a single JSON-encoded file.
  2. Image caching architecture with disk and network layers.
  3. Offline-first synchronization with mock REST endpoints.
  4. Generic `Repository<T>` pattern abstracting local and remote data sources.
  5. Caching system with 5-minute Time-To-Live (TTL) expiry timestamp.
  6. Nested JSON structure: `NestedStudentModel` containing `List<SubjectMark>`.
  7. Background synchronization queue flushing pending data upon reconnection.
  8. File-based audit logger writing timestamped events to `app_audit_roll35.log`.
  9. Network failure automatic fallback to local disk copy.
  10. Complete end-to-end offline data pipeline.

---

## 🗄️ Module V: Data Persistence (SharedPreferences, SQLite & Hive)

| Practical | File Path | Description |
|:---:|:---|:---|
| **V1** | [`module_v/q01_pref_save_username.dart`](flutter_practicals/lib/module_v/q01_pref_save_username.dart) | Saves username in `SharedPreferences` and reloads it upon app launch. |
| **V2** | [`module_v/q02_pref_dark_mode.dart`](flutter_practicals/lib/module_v/q02_pref_dark_mode.dart) | Switch toggling and persisting "Dark Mode" in `SharedPreferences`. |
| **V3** | [`module_v/q03_sqlite_products_table.dart`](flutter_practicals/lib/module_v/q03_sqlite_products_table.dart) | SQLite database with `products` table (`id`, `name`, `price`) with queries. |
| **V4** | [`module_v/q04_sqlite_insert_student.dart`](flutter_practicals/lib/module_v/q04_sqlite_insert_student.dart) | Inserts new student record into SQLite `students` table via SQL INSERT. |
| **V5** | [`module_v/q05_sqlite_listview_display.dart`](flutter_practicals/lib/module_v/q05_sqlite_listview_display.dart) | Queries SQLite `books` table and displays all records inside a `ListView.builder`. |
| **V6** | [`module_v/q06_sqlite_update_record.dart`](flutter_practicals/lib/module_v/q06_sqlite_update_record.dart) | Updates an existing SQLite record targeting its specific primary key `id`. |
| **V7** | [`module_v/q07_sqlite_delete_record.dart`](flutter_practicals/lib/module_v/q07_sqlite_delete_record.dart) | Deletes a record from an SQLite table by `id` with confirmation modal. |
| **V8** | [`module_v/q08_hive_simple_todo.dart`](flutter_practicals/lib/module_v/q08_hive_simple_todo.dart) | High-speed NoSQL key-value persistence for to-do items using Hive. |
| **V9** | [`module_v/q09_hive_user_name_age.dart`](flutter_practicals/lib/module_v/q09_hive_user_name_age.dart) | Stores compound user profile (name and age) in Hive NoSQL box. |
| **V10** | [`module_v/q10_file_storage_path_provider.dart`](flutter_practicals/lib/module_v/q10_file_storage_path_provider.dart) | Reads and writes text to a local device file using `path_provider`. |

---

## 🚀 How to Run & Verify

### 1. Running Dart Practicals
Each Dart practical can be executed directly from terminal:
```bash
cd dart_practicals

# Run any individual practical (e.g. Q1, Q13, Q25, Q30):
dart run q01_variables_interpolation.dart
dart run q13_set_operations.dart
dart run q25_interfaces_photo.dart
dart run q30_stream_multiplication.dart

# Run all 30 Dart Practicals in sequence:
for file in q*.dart; do
  echo "=== Running $file ==="
  dart run "$file"
done
```

### 2. Running Flutter Practicals
Launch the interactive master showcase app:
```bash
cd flutter_practicals

# Fetch dependencies
flutter pub get

# Run static analysis (verifies 0 errors and 0 warnings)
flutter analyze lib/

# Run the app on macOS Desktop, Chrome, or connected mobile device
flutter run -d macos
# Or for web:
# flutter run -d chrome
```

---
**Submission Prepared by:** Vadgama Priya Ashokbhai (Roll No: 35)  
**Status:** 100% Complete & Verified  
