import 'package:flutter/material.dart';

/// Hard Level - Practical 9:
/// Create Nested Navigation: each tab of a Bottom Navigation Bar has its own
/// separate Navigator stack (for example, using IndexedStack).

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q09NestedNavigationScreen(),
  ));
}

class Q09NestedNavigationScreen extends StatefulWidget {
  const Q09NestedNavigationScreen({super.key});

  @override
  State<Q09NestedNavigationScreen> createState() => _Q09NestedNavigationScreenState();
}

class _Q09NestedNavigationScreenState extends State<Q09NestedNavigationScreen> {
  int _currentIndex = 0;

  // Individual Navigator Keys for each Tab to maintain separate navigation stacks
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final bool isFirstRouteInCurrentTab = !await _navigatorKeys[_currentIndex].currentState!.maybePop();
        if (isFirstRouteInCurrentTab && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildTabNavigator(0, const TabScreen(tabName: 'Feed', color: Colors.blue)),
            _buildTabNavigator(1, const TabScreen(tabName: 'Explore', color: Colors.teal)),
            _buildTabNavigator(2, const TabScreen(tabName: 'Account', color: Colors.deepPurple)),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.indigo,
          onTap: (index) {
            if (_currentIndex == index) {
              // If tapped on current tab, pop to first route
              _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'),
            BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabNavigator(int index, Widget rootWidget) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => rootWidget,
        );
      },
    );
  }
}

class TabScreen extends StatelessWidget {
  final String tabName;
  final Color color;
  final int depth;

  const TabScreen({
    super.key,
    required this.tabName,
    required this.color,
    this.depth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$tabName Tab (Level $depth)'),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: color.withValues(alpha: 0.2),
                child: Text('$depth', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
              ),
              const SizedBox(height: 16),
              Text(
                'Stack Depth in $tabName: $depth',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Notice that navigating deeper in this tab preserves the state of other bottom tabs completely!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white),
                icon: const Icon(Icons.arrow_forward),
                label: Text('Push Level ${depth + 1} inside $tabName'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => TabScreen(tabName: tabName, color: color, depth: depth + 1),
                    ),
                  );
                },
              ),
              if (depth > 1) ...[
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Pop this sub-route'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
