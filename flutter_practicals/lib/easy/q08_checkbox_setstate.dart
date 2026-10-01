import 'package:flutter/material.dart';

/// Easy Level - Practical 8:
/// Toggle a checkbox using setState() and display 'Checked'/'Unchecked' text based on its state.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q08CheckboxSetStateScreen(),
  ));
}

class Q08CheckboxSetStateScreen extends StatefulWidget {
  const Q08CheckboxSetStateScreen({super.key});

  @override
  State<Q08CheckboxSetStateScreen> createState() => _Q08CheckboxSetStateScreenState();
}

class _Q08CheckboxSetStateScreenState extends State<Q08CheckboxSetStateScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Q8: Checkbox setState()'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display state banner
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                decoration: BoxDecoration(
                  color: _isChecked ? Colors.green.shade100 : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isChecked ? Colors.green : Colors.red,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isChecked ? Icons.check_circle : Icons.cancel,
                      color: _isChecked ? Colors.green.shade800 : Colors.red.shade800,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _isChecked ? 'Checked' : 'Unchecked',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _isChecked ? Colors.green.shade900 : Colors.red.shade900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: CheckboxListTile(
                  title: const Text(
                    'Accept Terms and Conditions',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  subtitle: Text(
                    _isChecked ? 'Status: Checkbox is Checked' : 'Status: Checkbox is Unchecked',
                  ),
                  value: _isChecked,
                  activeColor: Colors.teal,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
