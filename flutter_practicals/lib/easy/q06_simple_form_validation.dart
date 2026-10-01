import 'package:flutter/material.dart';

/// Easy Level - Practical 6:
/// Create a simple Form with one TextFormField that shows a 'Field required' error when submitted empty.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q06FormValidationScreen(),
  ));
}

class Q06FormValidationScreen extends StatefulWidget {
  const Q06FormValidationScreen({super.key});

  @override
  State<Q06FormValidationScreen> createState() => _Q06FormValidationScreenState();
}

class _Q06FormValidationScreenState extends State<Q06FormValidationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  String? _submittedText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _submittedText = _controller.text;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Form Submitted Successfully: $_submittedText'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Q6: Form Validation'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Student Name Input',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Submit without entering any value to trigger the validation error.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter Name',
                  hintText: 'e.g. Vadgama Priya Ashokbhai',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Field required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.check_circle_outline),
                label: const Text('Submit Form', style: TextStyle(fontSize: 16)),
                onPressed: _submit,
              ),
              if (_submittedText != null) ...[
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.shade300),
                  ),
                  child: Text(
                    'Submitted Value: $_submittedText',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
