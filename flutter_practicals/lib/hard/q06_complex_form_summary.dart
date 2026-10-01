import 'package:flutter/material.dart';

/// Hard Level - Practical 6:
/// Create a complex Form with a Dropdown, Checkbox, and TextFormField together,
/// and use Form.save() to pass all values to a Summary screen via navigation.

class RegistrationData {
  String fullName = '';
  String course = 'B.C.A. (C.S. & I.T.)';
  int semester = 5;
  bool hostelRequired = false;
  bool busService = false;
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q06ComplexFormScreen(),
  ));
}

class Q06ComplexFormScreen extends StatefulWidget {
  const Q06ComplexFormScreen({super.key});

  @override
  State<Q06ComplexFormScreen> createState() => _Q06ComplexFormScreenState();
}

class _Q06ComplexFormScreenState extends State<Q06ComplexFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final RegistrationData _formData = RegistrationData();

  final List<String> _courseOptions = [
    'B.C.A. (C.S. & I.T.)',
    'Information Technology',
    'Artificial Intelligence & Data Science',
    'Electronics & Communication',
  ];

  final List<int> _semesters = [1, 2, 3, 4, 5, 6, 7, 8];

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // Form.save() triggers onSaved callback on every FormField
      _formKey.currentState!.save();

      // Passing saved data object to Summary Screen via Navigation
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormSummaryScreen(data: _formData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hard Q6: Complex Form (Form.save)'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'College Semester Enrollment',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Complete all fields. Values will be captured using Form.save().',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              // 1. TextFormField
              TextFormField(
                initialValue: 'Vadgama Priya Ashokbhai',
                decoration: const InputDecoration(
                  labelText: 'Student Full Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Please enter student name' : null,
                onSaved: (val) => _formData.fullName = val?.trim() ?? '',
              ),
              const SizedBox(height: 16),
              // 2. DropdownButtonFormField for Course
              DropdownButtonFormField<String>(
                initialValue: _formData.course,
                decoration: const InputDecoration(
                  labelText: 'Degree Program / Branch',
                  prefixIcon: Icon(Icons.school),
                  border: OutlineInputBorder(),
                ),
                items: _courseOptions.map((course) {
                  return DropdownMenuItem(value: course, child: Text(course, style: const TextStyle(fontSize: 14)));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _formData.course = val);
                },
                onSaved: (val) => _formData.course = val ?? '',
              ),
              const SizedBox(height: 16),
              // 3. DropdownButtonFormField for Semester
              DropdownButtonFormField<int>(
                initialValue: _formData.semester,
                decoration: const InputDecoration(
                  labelText: 'Semester',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                ),
                items: _semesters.map((sem) {
                  return DropdownMenuItem(value: sem, child: Text('Semester $sem'));
                }).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _formData.semester = val);
                },
                onSaved: (val) => _formData.semester = val ?? 1,
              ),
              const SizedBox(height: 20),
              const Text('Campus Facilities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              // 4. CheckboxListTile for Hostel
              Card(
                child: CheckboxListTile(
                  title: const Text('Hostel Accommodation'),
                  subtitle: const Text('Need room on university campus'),
                  value: _formData.hostelRequired,
                  onChanged: (val) => setState(() => _formData.hostelRequired = val ?? false),
                ),
              ),
              // 5. CheckboxListTile for Bus
              Card(
                child: CheckboxListTile(
                  title: const Text('College Bus Facility'),
                  subtitle: const Text('Daily transit route service'),
                  value: _formData.busService,
                  onChanged: (val) => setState(() => _formData.busService = val ?? false),
                ),
              ),
              const SizedBox(height: 28),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.send),
                label: const Text('Save & View Summary Screen', style: TextStyle(fontSize: 16)),
                onPressed: _handleSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Summary Screen receiving data object
class FormSummaryScreen extends StatelessWidget {
  final RegistrationData data;

  const FormSummaryScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enrollment Summary'),
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.verified, size: 70, color: Colors.green),
            const SizedBox(height: 16),
            const Text(
              'Form Successfully Saved & Transferred!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _row('Student Name', data.fullName),
                    _row('Program', data.course),
                    _row('Current Semester', 'Semester ${data.semester}'),
                    _row('Hostel Facility', data.hostelRequired ? 'Requested (Yes)' : 'Not Required (No)'),
                    _row('Bus Transit', data.busService ? 'Subscribed (Yes)' : 'Not Required (No)'),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade800,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Edit Information'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
