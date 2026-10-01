import 'package:flutter/material.dart';

/// Section C - Hard Level - Practical 10:
/// Build a complete widget lifecycle logger utility: a wrapper StatefulWidget
/// that logs every lifecycle event (with timestamps) for any child widget passed
/// to it, and demonstrate it wrapping a Counter widget.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LifecycleLoggerHostScreen(),
  ));
}

// ================= LIFECYCLE LOGGER WRAPPER WIDGET =================
class WidgetLifecycleLogger extends StatefulWidget {
  final String tag;
  final Widget child;
  final void Function(String logEntry)? onLifecycleEvent;

  const WidgetLifecycleLogger({
    super.key,
    required this.tag,
    required this.child,
    this.onLifecycleEvent,
  });

  @override
  State<WidgetLifecycleLogger> createState() => _WidgetLifecycleLoggerState();
}

class _WidgetLifecycleLoggerState extends State<WidgetLifecycleLogger> {
  void _log(String eventName, [String? extra]) {
    final timestamp = DateTime.now().toIso8601String().substring(11, 23);
    final message = '[$timestamp] [${widget.tag}] -> $eventName ${extra ?? ""}';
    debugPrint(message);
    if (widget.onLifecycleEvent != null) {
      widget.onLifecycleEvent!(message);
    }
  }

  @override
  void initState() {
    super.initState();
    _log('initState()', 'State instance created and added to tree');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _log('didChangeDependencies()', 'InheritedWidget dependencies resolved');
  }

  @override
  void didUpdateWidget(covariant WidgetLifecycleLogger oldWidget) {
    super.didUpdateWidget(oldWidget);
    _log('didUpdateWidget()', 'Parent rebuilt; child configuration updated');
  }

  @override
  void deactivate() {
    _log('deactivate()', 'State removed from tree temporarily/permanently');
    super.deactivate();
  }

  @override
  void dispose() {
    _log('dispose()', 'State permanently discarded from memory');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _log('build()', 'Rendering child widget subtree');
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.indigo.shade300, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(12),
      child: widget.child,
    );
  }
}

// ================= DEMO HOST SCREEN WRAPPING A COUNTER =================
class LifecycleLoggerHostScreen extends StatefulWidget {
  const LifecycleLoggerHostScreen({super.key});

  @override
  State<LifecycleLoggerHostScreen> createState() => _LifecycleLoggerHostScreenState();
}

class _LifecycleLoggerHostScreenState extends State<LifecycleLoggerHostScreen> {
  int _counter = 0;
  bool _showChild = true;
  final List<String> _eventLogs = [];

  void _recordEvent(String entry) {
    setState(() {
      _eventLogs.insert(0, entry); // Insert at top
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Section C Q10: Lifecycle Logger'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Clear Logs',
            icon: const Icon(Icons.delete_sweep),
            onPressed: () => setState(() => _eventLogs.clear()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Controls row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                  icon: const Icon(Icons.add),
                  label: const Text('Increment Counter'),
                  onPressed: () {
                    setState(() {
                      _counter++;
                    });
                  },
                ),
                OutlinedButton.icon(
                  icon: Icon(_showChild ? Icons.visibility_off : Icons.visibility),
                  label: Text(_showChild ? 'Unmount Widget' : 'Mount Widget'),
                  onPressed: () {
                    setState(() {
                      _showChild = !_showChild;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            // The Wrapped Child Widget
            if (_showChild)
              WidgetLifecycleLogger(
                tag: 'CounterWidget',
                onLifecycleEvent: _recordEvent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Wrapped Child Widget (Active in tree)',
                        style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      'Counter: $_counter',
                      style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: const Text(
                  'Child Widget unmounted! (Check dispose & deactivate logs below)',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 16),
            // Real-time Event Log stream
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Real-time Lifecycle Logs (${_eventLogs.length})',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                TextButton(
                  onPressed: () => setState(() => _eventLogs.clear()),
                  child: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _eventLogs.isEmpty
                    ? const Center(
                        child: Text(
                          'No events recorded yet. Interact with buttons above.',
                          style: TextStyle(color: Colors.white60),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _eventLogs.length,
                        itemBuilder: (context, index) {
                          final log = _eventLogs[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Text(
                              log,
                              style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                                color: log.contains('initState')
                                    ? Colors.greenAccent
                                    : log.contains('build')
                                        ? Colors.cyanAccent
                                        : log.contains('dispose') || log.contains('deactivate')
                                            ? Colors.redAccent
                                            : Colors.amberAccent,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
