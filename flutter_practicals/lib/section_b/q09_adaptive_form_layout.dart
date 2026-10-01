// Section B - Practical 9: Adaptive Form Layout via MediaQuery
// Build a form screen that adapts its field layout (single column vs two columns side by side)
// based on MediaQuery screen width.

import 'package:flutter/material.dart';

class SectionBQ09AdaptiveFormLayout extends StatefulWidget {
  const SectionBQ09AdaptiveFormLayout({super.key});

  @override
  State<SectionBQ09AdaptiveFormLayout> createState() => _SectionBQ09AdaptiveFormLayoutState();
}

class _SectionBQ09AdaptiveFormLayoutState extends State<SectionBQ09AdaptiveFormLayout> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController(text: 'Priya');
  final _lastNameController = TextEditingController(text: 'Vadgama');
  final _emailController = TextEditingController(text: '15612424037@atmiyauni.edu.in');
  final _phoneController = TextEditingController(text: '+91 98765 43210');
  final _rollController = TextEditingController(text: '35');
  final _deptController = TextEditingController(text: 'B.C.A. (C.S. & I.T.)');

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _rollController.dispose();
    _deptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen width using MediaQuery
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth >= 650;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sec B - Q9: Adaptive Form Layout'),
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isWideScreen ? Colors.indigo.shade50 : Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: isWideScreen ? Colors.indigo : Colors.amber.shade700),
                ),
                child: Row(
                  children: [
                    Icon(isWideScreen ? Icons.desktop_windows : Icons.smartphone,
                        color: isWideScreen ? Colors.indigo : Colors.amber.shade900),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'MediaQuery Width: ${screenWidth.toStringAsFixed(1)} dp\n'
                        'Adaptive Mode: ${isWideScreen ? "Two Columns Side-by-Side (Desktop/Tablet)" : "Single Column Stacked (Mobile)"}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isWideScreen ? Colors.indigo.shade900 : Colors.amber.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('Student Registration Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // Adaptive Fields Section 1: First Name & Last Name
              if (isWideScreen)
                Row(
                  children: [
                    Expanded(child: _buildTextField('First Name', _firstNameController, Icons.person)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildTextField('Last Name', _lastNameController, Icons.person_outline)),
                  ],
                )
              else ...[
                _buildTextField('First Name', _firstNameController, Icons.person),
                const SizedBox(height: 14),
                _buildTextField('Last Name', _lastNameController, Icons.person_outline),
              ],

              const SizedBox(height: 14),

              // Adaptive Fields Section 2: Email & Phone
              if (isWideScreen)
                Row(
                  children: [
                    Expanded(child: _buildTextField('Email Address', _emailController, Icons.email)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildTextField('Phone Number', _phoneController, Icons.phone)),
                  ],
                )
              else ...[
                _buildTextField('Email Address', _emailController, Icons.email),
                const SizedBox(height: 14),
                _buildTextField('Phone Number', _phoneController, Icons.phone),
              ],

              const SizedBox(height: 14),

              // Adaptive Fields Section 3: Roll Number & Department
              if (isWideScreen)
                Row(
                  children: [
                    Expanded(child: _buildTextField('Roll Number', _rollController, Icons.badge)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildTextField('Department', _deptController, Icons.school)),
                  ],
                )
              else ...[
                _buildTextField('Roll Number', _rollController, Icons.badge),
                const SizedBox(height: 14),
                _buildTextField('Department', _deptController, Icons.school),
              ],

              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Profile saved: ${_firstNameController.text} ${_lastNameController.text} (Roll: ${_rollController.text})'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo.shade800,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Save & Validate Record', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (val) {
        if (val == null || val.trim().isEmpty) {
          return '$label is required';
        }
        return null;
      },
    );
  }
}
