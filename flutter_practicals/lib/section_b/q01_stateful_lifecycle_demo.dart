// Section B - Practical 1: StatefulWidget Lifecycle Logger
// Build a StatefulWidget lifecycle demo app that prints a message to the console
// at each lifecycle stage (initState, didChangeDependencies, build, setState, deactivate, dispose).

import 'package:flutter/material.dart';

class SectionBQ01StatefulLifecycleDemo extends StatefulWidget {
  const SectionBQ01StatefulLifecycleDemo({super.key});

  @override
  State<SectionBQ01StatefulLifecycleDemo> createState() => _SectionBQ01StatefulLifecycleDemoState();
}

class _SectionBQ01StatefulLifecycleDemoState extends State<SectionBQ01StatefulLifecycleDemo> {
  bool _showChild = true;
  final List<String> _logHistory = [];

  void _addLog(String msg) {
    debugPrint(msg);
    setState(() {
      _logHistory.insert(0, '[${DateTime.now().toIso8601String().substring(11, 19)}] $msg');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec B - Q1: Widget Lifecycle'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _showChild = !_showChild;
                    });
                  },
                  icon: Icon(_showChild ? Icons.visibility_off : Icons.visibility),
                  label: Text(_showChild ? 'Dispose Child Widget' : 'Mount Child Widget'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _logHistory.clear()),
                  child: const Text('Clear Logs'),
                ),
              ],
            ),
          ),
          if (_showChild)
            _LifecycleChildWidget(onLog: _addLog)
          else
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text('Child widget has been unmounted & disposed.', style: TextStyle(color: Colors.red)),
            ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Lifecycle Event Console Output:', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _logHistory.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                return Text(
                  _logHistory[index],
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LifecycleChildWidget extends StatefulWidget {
  final Function(String) onLog;
  const _LifecycleChildWidget({required this.onLog});

  @override
  State<_LifecycleChildWidget> createState() => _LifecycleChildWidgetState();
}

class _LifecycleChildWidgetState extends State<_LifecycleChildWidget> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    widget.onLog('🔵 [initState] Called once when widget is inserted into widget tree.');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.onLog('🟣 [didChangeDependencies] Called after initState & whenever inherited dependencies change.');
  }

  @override
  void didUpdateWidget(covariant _LifecycleChildWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.onLog('🟠 [didUpdateWidget] Called when parent rebuilds and provides new widget configuration.');
  }

  @override
  void deactivate() {
    widget.onLog('🟡 [deactivate] Called when widget is removed from tree temporarily.');
    super.deactivate();
  }

  @override
  void dispose() {
    widget.onLog('🔴 [dispose] Called permanently when widget is removed and garbage collected.');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.onLog('🟢 [build] Executed to render the widget tree (counter = $_counter).');
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      color: Colors.blueGrey.shade50,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text('Active Child Widget', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Local State Counter: $_counter', style: const TextStyle(fontSize: 20, color: Colors.blueGrey)),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter++;
                  widget.onLog('⚡ [setState] Triggered state change! Rebuild scheduled.');
                });
              },
              child: const Text('Call setState() to Rebuild'),
            ),
          ],
        ),
      ),
    );
  }
}
