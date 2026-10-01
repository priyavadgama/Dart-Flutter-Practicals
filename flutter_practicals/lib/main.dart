import 'package:flutter/material.dart';

// Section A - Easy Level UI Practicals
import 'section_a/q01_stateless_student_info.dart';
import 'section_a/q02_counter_stateful.dart';
import 'section_a/q03_scaffold_appbar_fab.dart';
import 'section_a/q04_listview_fruits.dart';
import 'section_a/q05_gridview_colored_boxes.dart';
import 'section_a/q06_card_widget_image_desc.dart';
import 'section_a/q07_drawer_navigation.dart';
import 'section_a/q08_bottom_navigation_bar.dart';
import 'section_a/q09_stack_text_container.dart';
import 'section_a/q10_custom_section_title.dart';

// Section B - Moderate Level UI Practicals
import 'section_b/q01_stateful_lifecycle_demo.dart';
import 'section_b/q02_responsive_column_row.dart';
import 'section_b/q03_product_grid_card.dart';
import 'section_b/q04_profile_card_widget.dart';
import 'section_b/q05_skill_tag_wrap_chips.dart';
import 'section_b/q06_badge_icon_stack.dart';
import 'section_b/q07_tabbar_media_views.dart';
import 'section_b/q08_settings_table_widget.dart';
import 'section_b/q09_adaptive_form_layout.dart';
import 'section_b/q10_custom_expansion_accordion.dart';

// Section C - Hard Level UI Practicals
import 'section_c/q01_responsive_dashboard.dart';
import 'section_c/q02_custom_widget_library.dart';
import 'section_c/q03_product_detail_screen.dart';
import 'section_c/q04_todo_didupdatewidget.dart';
import 'section_c/q05_responsive_nav_shell.dart';
import 'section_c/q06_profile_tabs_grid_list.dart';
import 'section_c/q07_intrinsic_height_news_feed.dart';
import 'section_c/q08_overlapping_profile_header.dart';
import 'section_c/q09_reflowing_settings_screen.dart';
import 'section_c/q10_widget_lifecycle_logger.dart';

// Module III - State Management (Easy)
import 'easy/q01_listview_names.dart';
import 'easy/q02_listtile_icon_text.dart';
import 'easy/q03_gridview_colors.dart';
import 'easy/q04_navigation_push_pop.dart';
import 'easy/q05_named_routes.dart';
import 'easy/q06_simple_form_validation.dart';
import 'easy/q07_counter_setstate.dart';
import 'easy/q08_checkbox_setstate.dart';
import 'easy/q09_counter_changenotifier.dart';
import 'easy/q10_read_vs_watch.dart';

// Module III - State Management (Moderate)
import 'moderate/q01_product_catalog_grid.dart';
import 'moderate/q02_search_filter_listview.dart';
import 'moderate/q03_pass_student_object.dart';
import 'moderate/q04_pop_data_snackbar.dart';
import 'moderate/q05_registration_form_validation.dart';
import 'moderate/q06_login_form_credentials.dart';
import 'moderate/q07_todo_list_setstate.dart';
import 'moderate/q08_shopping_cart_provider.dart';
import 'moderate/q09_star_rating_widget.dart';
import 'moderate/q10_star_pattern_screen.dart';

// Module III - State Management (Hard)
import 'hard/q01_form_wizard_navigation.dart';
import 'hard/q02_mini_ecommerce_provider.dart';
import 'hard/q03_todo_riverpod.dart';
import 'hard/q04_counter_bloc.dart';
import 'hard/q05_toggle_list_grid.dart';
import 'hard/q06_complex_form_summary.dart';
import 'hard/q07_theme_switcher_provider.dart';
import 'hard/q08_number_pyramid.dart';
import 'hard/q09_nested_navigation_indexedstack.dart';
import 'hard/q10_multi_user_login_provider.dart';

// Module IV - File Persistence & Caching
import 'module_iv/module_iv_easy.dart';
import 'module_iv/module_iv_moderate.dart';
import 'module_iv/module_iv_hard.dart';

// Module V - Data Persistence (SharedPreferences, SQLite, Hive, File Storage)
import 'module_v/q01_pref_save_username.dart';
import 'module_v/q02_pref_dark_mode.dart';
import 'module_v/q03_sqlite_products_table.dart';
import 'module_v/q04_sqlite_insert_student.dart';
import 'module_v/q05_sqlite_listview_display.dart';
import 'module_v/q06_sqlite_update_record.dart';
import 'module_v/q07_sqlite_delete_record.dart';
import 'module_v/q08_hive_simple_todo.dart';
import 'module_v/q09_hive_user_name_age.dart';
import 'module_v/q10_file_storage_path_provider.dart';

void main() {
  runApp(const PracticalsShowcaseApp());
}

class PracticalEntry {
  final String number;
  final String title;
  final String description;
  final WidgetBuilder builder;

  const PracticalEntry({
    required this.number,
    required this.title,
    required this.description,
    required this.builder,
  });
}

class PracticalsShowcaseApp extends StatelessWidget {
  const PracticalsShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practicals Showcase - Vadgama Priya Ashokbhai',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F8FA),
      ),
      home: const PracticalsDashboard(),
    );
  }
}

class PracticalsDashboard extends StatefulWidget {
  const PracticalsDashboard({super.key});

  @override
  State<PracticalsDashboard> createState() => _PracticalsDashboardState();
}

class _PracticalsDashboardState extends State<PracticalsDashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // 1. Section A UI (10)
  final List<PracticalEntry> sectionAList = [
    PracticalEntry(
      number: 'A1',
      title: 'StatelessWidget Student Info',
      description: 'Displays name, college name, and course in three Text widgets in a Column.',
      builder: (_) => const SectionAQ01StatelessStudentInfo(),
    ),
    PracticalEntry(
      number: 'A2',
      title: 'Counter App with StatefulWidget',
      description: 'Simple counter app with increment and decrement buttons using setState.',
      builder: (_) => const SectionAQ02CounterStateful(),
    ),
    PracticalEntry(
      number: 'A3',
      title: 'Scaffold, AppBar & FAB',
      description: 'Standard screen structure with AppBar, body Text, and FloatingActionButton.',
      builder: (_) => const SectionAQ03ScaffoldAppBarFAB(),
    ),
    PracticalEntry(
      number: 'A4',
      title: 'ListView.builder Fruits (10+)',
      description: 'Displays a list of 12 fruit names with caloric details using ListView.builder.',
      builder: (_) => const SectionAQ04ListViewFruits(),
    ),
    PracticalEntry(
      number: 'A5',
      title: 'GridView.count Colored Boxes',
      description: 'Displays 6 coloured boxes with 2 items per row using GridView.count.',
      builder: (_) => const SectionAQ05GridViewColoredBoxes(),
    ),
    PracticalEntry(
      number: 'A6',
      title: 'Card Widget Image & Description',
      description: 'Card with gradient banner representation, project title, and description.',
      builder: (_) => const SectionAQ06CardWidgetImageDesc(),
    ),
    PracticalEntry(
      number: 'A7',
      title: 'Drawer Navigation (5 Items)',
      description: 'Drawer navigation menu with user header and ListTile destinations.',
      builder: (_) => const SectionAQ07DrawerNavigation(),
    ),
    PracticalEntry(
      number: 'A8',
      title: 'BottomNavigationBar (3 Tabs)',
      description: '3-tab bottom navigation for Home, Search, and Profile screens.',
      builder: (_) => const SectionAQ08BottomNavigationBar(),
    ),
    PracticalEntry(
      number: 'A9',
      title: 'Stack Widget with Text Overlay',
      description: 'Text label and live status badge layered on top of a coloured container.',
      builder: (_) => const SectionAQ09StackTextContainer(),
    ),
    PracticalEntry(
      number: 'A10',
      title: 'Reusable SectionTitle Widget',
      description: 'Custom SectionTitle widget reused across Academics and Settings screens.',
      builder: (_) => const SectionAQ10CustomSectionTitle(),
    ),
  ];

  // 2. Section B UI (10)
  final List<PracticalEntry> sectionBList = [
    PracticalEntry(
      number: 'B1',
      title: 'StatefulWidget Lifecycle Logger',
      description: 'Prints messages to console at initState, build, didUpdateWidget, dispose.',
      builder: (_) => const SectionBQ01StatefulLifecycleDemo(),
    ),
    PracticalEntry(
      number: 'B2',
      title: 'Responsive Column / Row (LayoutBuilder)',
      description: 'Switches between Column on mobile and Row on tablet/desktop via LayoutBuilder.',
      builder: (_) => const SectionBQ02ResponsiveColumnRow(),
    ),
    PracticalEntry(
      number: 'B3',
      title: 'Product Grid Listing (GridView.builder)',
      description: 'Grid cards with image, product title, and price in a responsive grid.',
      builder: (_) => const SectionBQ03ProductGridCard(),
    ),
    PracticalEntry(
      number: 'B4',
      title: 'Custom ProfileCard (3 Reuses)',
      description: 'Reusable ProfileCard widget instantiated 3 times with custom callbacks.',
      builder: (_) => const SectionBQ04ProfileCardWidget(),
    ),
    PracticalEntry(
      number: 'B5',
      title: 'Skill Tag Selector (Wrap & Chips)',
      description: 'Dynamic tag/skill selector using Wrap and interactive FilterChips.',
      builder: (_) => const SectionBQ05SkillTagWrapChips(),
    ),
    PracticalEntry(
      number: 'B6',
      title: 'Notification Badge Icon (Stack & Positioned)',
      description: 'Notification count badge positioned on top of mail and bell icons.',
      builder: (_) => const SectionBQ06BadgeIconStack(),
    ),
    PracticalEntry(
      number: 'B7',
      title: 'TabBar Media Views (Photos/Videos/Files)',
      description: '3 tabs with TabBarView showing grid, list, and download tiles.',
      builder: (_) => const SectionBQ07TabBarMediaViews(),
    ),
    PracticalEntry(
      number: 'B8',
      title: 'Settings Screen with Table Widget',
      description: 'Aligned key-value configuration rows and columns using Table.',
      builder: (_) => const SectionBQ08SettingsTableWidget(),
    ),
    PracticalEntry(
      number: 'B9',
      title: 'Adaptive Form Layout (MediaQuery)',
      description: 'Adapts form fields between 1 column (mobile) and 2 columns (tablet/desktop).',
      builder: (_) => const SectionBQ09AdaptiveFormLayout(),
    ),
    PracticalEntry(
      number: 'B10',
      title: 'ExpansionTile FAQ Accordion',
      description: 'Interactive collapsible accordion with custom animations and state.',
      builder: (_) => const SectionBQ10CustomExpansionAccordion(),
    ),
  ];

  // 3. Section C Hard UI (10)
  final List<PracticalEntry> sectionCList = [
    PracticalEntry(
      number: 'C1',
      title: 'Responsive 3-Panel Dashboard',
      description: 'Single-col mobile, 2-col tablet, 3-panel desktop via LayoutBuilder & MediaQuery.',
      builder: (_) => const Q01ResponsiveDashboardScreen(),
    ),
    PracticalEntry(
      number: 'C2',
      title: 'Reusable Widget Library',
      description: 'CustomButton, CustomCard, and CustomAppBar integrated into one demo.',
      builder: (_) => const Q02CustomWidgetLibraryDemoScreen(),
    ),
    PracticalEntry(
      number: 'C3',
      title: 'Product Detail Screen',
      description: 'Stack badge overlay, Wrap tags, and Flexible price/action bottom bar.',
      builder: (_) => const Q03ProductDetailScreen(),
    ),
    PracticalEntry(
      number: 'C4',
      title: 'To-Do with didUpdateWidget',
      description: 'Parent-child todo list demonstrating lifecycle and reactive completion.',
      builder: (_) => const TodoParentHostScreen(),
    ),
    PracticalEntry(
      number: 'C5',
      title: 'Responsive Navigation Shell',
      description: 'Mobile Drawer vs Desktop NavigationRail switching automatically.',
      builder: (_) => const Q05ResponsiveNavShellScreen(),
    ),
    PracticalEntry(
      number: 'C6',
      title: 'Multi-Tab Profile Screen',
      description: 'Combines TabBar, GridView photo grid, and ListView activity feed.',
      builder: (_) => const Q06ProfileTabsScreen(),
    ),
    PracticalEntry(
      number: 'C7',
      title: 'IntrinsicHeight News Feed',
      description: 'Cards using IntrinsicHeight to perfectly match thumbnail and article text.',
      builder: (_) => const Q07IntrinsicHeightNewsFeedScreen(),
    ),
    PracticalEntry(
      number: 'C8',
      title: 'Overlapping Profile Header',
      description: 'Stack & Positioned banner with overlapping circular profile avatar.',
      builder: (_) => const Q08OverlappingProfileHeaderScreen(),
    ),
    PracticalEntry(
      number: 'C9',
      title: 'Reflowing Settings Screen',
      description: 'Grouped sections using Table reflowing into 2 columns above 700dp.',
      builder: (_) => const Q09ReflowingSettingsScreen(),
    ),
    PracticalEntry(
      number: 'C10',
      title: 'Widget Lifecycle Logger Utility',
      description: 'Stateful wrapper logging all lifecycle events with millisecond timestamps.',
      builder: (_) => const LifecycleLoggerHostScreen(),
    ),
  ];

  // 4. Module III State Management (Easy 10)
  final List<PracticalEntry> stateEasyList = [
    PracticalEntry(
      number: 'SE1',
      title: 'ListView.builder Fixed Names',
      description: '10 student names displayed efficiently with scroll optimization.',
      builder: (_) => const Q01ListViewNamesScreen(),
    ),
    PracticalEntry(
      number: 'SE2',
      title: 'ListTile with Icon & Text',
      description: 'Features icons, student names, and subtitle roll numbers.',
      builder: (_) => const Q02ListTileIconTextScreen(),
    ),
    PracticalEntry(
      number: 'SE3',
      title: 'GridView.builder Colored Boxes',
      description: '6 distinct material colors in a 2-column grid layout.',
      builder: (_) => const Q03GridViewColoredBoxesScreen(),
    ),
    PracticalEntry(
      number: 'SE4',
      title: 'Navigator push & pop',
      description: 'Screen navigation passing parameters between HomeScreen & SecondScreen.',
      builder: (_) => const HomeScreen(),
    ),
    PracticalEntry(
      number: 'SE5',
      title: 'Named Routes Navigation',
      description: 'Routing between Home, About, and Contact using routes table.',
      builder: (_) => const Q05NamedRoutesApp(),
    ),
    PracticalEntry(
      number: 'SE6',
      title: 'Form Validation (Field Required)',
      description: 'Form with validator ensuring input is non-empty before submission.',
      builder: (_) => const Q06FormValidationScreen(),
    ),
    PracticalEntry(
      number: 'SE7',
      title: 'Counter App using setState',
      description: 'StatefulWidget updating UI reactively with increment and decrement.',
      builder: (_) => const Q07CounterSetStateScreen(),
    ),
    PracticalEntry(
      number: 'SE8',
      title: 'Checkbox Toggle setState',
      description: 'Reactive Checkbox displaying Checked / Unchecked status.',
      builder: (_) => const Q08CheckboxSetStateScreen(),
    ),
    PracticalEntry(
      number: 'SE9',
      title: 'ChangeNotifier Counter & Consumer',
      description: 'Provider-based reactive counter utilizing Consumer<CounterModel>.',
      builder: (_) => const Q09ConsumerCounterScreen(),
    ),
    PracticalEntry(
      number: 'SE10',
      title: 'context.read vs context.watch',
      description: 'Demonstrating when rebuilds trigger (watch) vs one-off reads (read).',
      builder: (_) => const Q10ReadVsWatchScreen(),
    ),
  ];

  // 5. Module III State Management (Moderate 10)
  final List<PracticalEntry> stateModList = [
    PracticalEntry(
      number: 'SM1',
      title: 'Product Catalog GridView (3 Cols)',
      description: '3-column responsive grid with prices and add-to-cart badges.',
      builder: (_) => const Q01ProductCatalogGridScreen(),
    ),
    PracticalEntry(
      number: 'SM2',
      title: 'Search-based Filtering ListView',
      description: 'Real-time filtering of a list of student records based on search query.',
      builder: (_) => const Q02SearchFilterListViewScreen(),
    ),
    PracticalEntry(
      number: 'SM3',
      title: 'Pass Student Object Navigation',
      description: 'Strongly-typed data transfer of Student model across screens.',
      builder: (_) => const Q03StudentHomeScreen(),
    ),
    PracticalEntry(
      number: 'SM4',
      title: 'Pop Data Back to SnackBar',
      description: 'Awaits Navigator.pop(context, result) and displays outcome in SnackBar.',
      builder: (_) => const Q04PopDataHomeScreen(),
    ),
    PracticalEntry(
      number: 'SM5',
      title: 'Registration Form Validation',
      description: 'Regex email verification and minimum password length constraints.',
      builder: (_) => const Q05RegistrationFormScreen(),
    ),
    PracticalEntry(
      number: 'SM6',
      title: 'Login Form Credentials & Nav',
      description: 'Authenticates student credentials and navigates on success.',
      builder: (_) => const Q06LoginFormScreen(),
    ),
    PracticalEntry(
      number: 'SM7',
      title: 'To-Do List using setState',
      description: 'Interactive add and swipe-to-delete to-do tasks with animation.',
      builder: (_) => const Q07TodoListSetStateScreen(),
    ),
    PracticalEntry(
      number: 'SM8',
      title: 'Shopping Cart using Provider',
      description: 'Real-time price accumulation and cart count management.',
      builder: (_) => const Q08ShoppingCartScreen(),
    ),
    PracticalEntry(
      number: 'SM9',
      title: 'Star Rating Widget (1 to 5)',
      description: 'Interactive tap rating updating filled stars reactively.',
      builder: (_) => const Q09StarRatingScreen(),
    ),
    PracticalEntry(
      number: 'SM10',
      title: 'Dynamic Star Pattern Screen',
      description: 'Takes user input N and generates N rows of star patterns.',
      builder: (_) => const Q10StarPatternScreen(),
    ),
  ];

  // 6. Module III State Management (Hard 10)
  final List<PracticalEntry> stateHardList = [
    PracticalEntry(
      number: 'SH1',
      title: 'Multi-step Form Wizard',
      description: '3-step validated wizard (Info -> Address -> Review) with forward/back.',
      builder: (_) => const WizardStep1Screen(),
    ),
    PracticalEntry(
      number: 'SH2',
      title: 'Mini E-commerce Provider App',
      description: 'Catalog -> Provider Cart -> Checkout Summary data pipeline.',
      builder: (_) => const EcomCatalogScreen(),
    ),
    PracticalEntry(
      number: 'SH3',
      title: 'Todo App with Riverpod',
      description: 'StateNotifierProvider managing add, toggle, and delete operations.',
      builder: (_) => const Q03TodoRiverpodScreen(),
    ),
    PracticalEntry(
      number: 'SH4',
      title: 'Counter App with flutter_bloc',
      description: 'Clean BLoC event and state stream architecture with BlocBuilder.',
      builder: (_) => const Q04CounterBlocScreen(),
    ),
    PracticalEntry(
      number: 'SH5',
      title: 'Toggle ListView vs GridView',
      description: 'Single-tap view transformation preserving underlying dataset.',
      builder: (_) => const Q05ToggleListGridScreen(),
    ),
    PracticalEntry(
      number: 'SH6',
      title: 'Complex Form to Summary Screen',
      description: 'Dropdown, Checkbox, TextFields saved together and passed via router.',
      builder: (_) => const Q06ComplexFormScreen(),
    ),
    PracticalEntry(
      number: 'SH7',
      title: 'Theme Switcher with Provider',
      description: 'Global ThemeProvider toggling Dark/Light mode across all views.',
      builder: (_) => const Q07ThemeSwitcherScreen(),
    ),
    PracticalEntry(
      number: 'SH8',
      title: 'Dynamic Number Pyramid',
      description: 'Calculates and formats numeric pyramid structure dynamically.',
      builder: (_) => const Q08NumberPyramidScreen(),
    ),
    PracticalEntry(
      number: 'SH9',
      title: 'Nested Navigation (IndexedStack)',
      description: 'Independent navigation stacks inside BottomNavigationBar tabs.',
      builder: (_) => const Q09NestedNavigationScreen(),
    ),
    PracticalEntry(
      number: 'SH10',
      title: 'Multi-User Login with Provider',
      description: 'Validates credentials against Provider List<User> database.',
      builder: (_) => const Q10MultiUserLoginScreen(),
    ),
  ];

  // 7. Module IV Data Persistence & Caching
  final List<PracticalEntry> moduleIVList = [
    PracticalEntry(
      number: 'M4-E',
      title: 'Module IV: Level 1 - Easy Suite (Q1 to Q10)',
      description: 'File I/O, getApplicationDocumentsDirectory, exists/delete, SharedPreferences, in-memory cache, JSON encode/decode.',
      builder: (_) => const ModuleIVEasyPracticals(),
    ),
    PracticalEntry(
      number: 'M4-M',
      title: 'Module IV: Level 2 - Moderate Suite (Q1 to Q10)',
      description: 'Notes file overwrite/append, StudentModel JSON serialization, cache-first loader, SharedPreferences lists & offline queue.',
      builder: (_) => const ModuleIVModeratePracticals(),
    ),
    PracticalEntry(
      number: 'M4-H',
      title: 'Module IV: Level 3 - Hard Suite (Q1 to Q10)',
      description: 'Notes CRUD in JSON file, Generic Repository pattern, 5-min TTL cache expiry, nested models, file logger & offline pipeline.',
      builder: (_) => const ModuleIVHardPracticals(),
    ),
  ];

  // 8. Module V Data Persistence (10)
  final List<PracticalEntry> moduleVList = [
    PracticalEntry(
      number: 'V1',
      title: 'SharedPreferences Save Username',
      description: 'Persists username to local storage and reloads upon reboot.',
      builder: (_) => const ModuleVQ01PrefSaveUsername(),
    ),
    PracticalEntry(
      number: 'V2',
      title: 'Dark Mode Switch (SharedPreferences)',
      description: 'Toggles and persists theme mode selection across app restarts.',
      builder: (_) => const ModuleVQ02PrefDarkMode(),
    ),
    PracticalEntry(
      number: 'V3',
      title: 'SQLite "products" Table',
      description: 'Creates table (id, name, price) and queries records via SQL.',
      builder: (_) => const ModuleVQ03SqliteProductsTable(),
    ),
    PracticalEntry(
      number: 'V4',
      title: 'SQLite Insert "students" Record',
      description: 'Executes parameterized SQL INSERT for student profiles.',
      builder: (_) => const ModuleVQ04SqliteInsertStudent(),
    ),
    PracticalEntry(
      number: 'V5',
      title: 'SQLite ListView Display',
      description: 'Queries library books table and renders dynamically in ListView.',
      builder: (_) => const ModuleVQ05SqliteListViewDisplay(),
    ),
    PracticalEntry(
      number: 'V6',
      title: 'SQLite Update Record by ID',
      description: 'Executes SQL UPDATE where id = ? for employee records.',
      builder: (_) => const ModuleVQ06SqliteUpdateRecord(),
    ),
    PracticalEntry(
      number: 'V7',
      title: 'SQLite Delete Record by ID',
      description: 'Executes SQL DELETE where id = ? with user confirmation.',
      builder: (_) => const ModuleVQ07SqliteDeleteRecord(),
    ),
    PracticalEntry(
      number: 'V8',
      title: 'Hive Simple To-Do Note',
      description: 'Fast NoSQL key-value persistence for to-do items using Hive.',
      builder: (_) => const ModuleVQ08HiveSimpleTodo(),
    ),
    PracticalEntry(
      number: 'V9',
      title: 'Hive User Name & Age Storage',
      description: 'Stores compound user profile object with name and age in Hive.',
      builder: (_) => const ModuleVQ09HiveUserNameAge(),
    ),
    PracticalEntry(
      number: 'V10',
      title: 'File Storage with path_provider',
      description: 'Reads and writes local text files on device documents directory.',
      builder: (_) => const ModuleVQ10FileStoragePathProvider(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Flutter Practical Lab Repository', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Candidate: Vadgama Priya Ashokbhai | Roll No: 35 | Atmiya University, Rajkot', style: TextStyle(fontSize: 12, color: Colors.white70)),
          ],
        ),
        backgroundColor: Colors.indigo.shade900,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.amberAccent,
          indicatorWeight: 3,
          labelColor: Colors.amberAccent,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.palette_outlined), text: 'Section A UI (10)'),
            Tab(icon: Icon(Icons.dashboard_customize), text: 'Section B UI (10)'),
            Tab(icon: Icon(Icons.view_quilt), text: 'Section C UI (10)'),
            Tab(icon: Icon(Icons.speed), text: 'State Easy (10)'),
            Tab(icon: Icon(Icons.bolt), text: 'State Mod (10)'),
            Tab(icon: Icon(Icons.military_tech), text: 'State Hard (10)'),
            Tab(icon: Icon(Icons.cloud_sync), text: 'Module IV File/Cache'),
            Tab(icon: Icon(Icons.storage), text: 'Module V DB/Hive (10)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPracticalListView(sectionAList, Colors.teal),
          _buildPracticalListView(sectionBList, Colors.blue),
          _buildPracticalListView(sectionCList, Colors.indigo),
          _buildPracticalListView(stateEasyList, Colors.green),
          _buildPracticalListView(stateModList, Colors.deepOrange),
          _buildPracticalListView(stateHardList, Colors.purple),
          _buildPracticalListView(moduleIVList, Colors.cyan.shade800),
          _buildPracticalListView(moduleVList, Colors.amber.shade900),
        ],
      ),
    );
  }

  Widget _buildPracticalListView(List<PracticalEntry> list, Color badgeColor) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: badgeColor.withValues(alpha: 0.15),
              child: Text(
                item.number,
                style: TextStyle(color: badgeColor, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item.description, style: const TextStyle(fontSize: 12, color: Colors.black87)),
            trailing: const Icon(Icons.play_circle_fill, color: Colors.indigo, size: 30),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: item.builder),
              );
            },
          ),
        );
      },
    );
  }
}
