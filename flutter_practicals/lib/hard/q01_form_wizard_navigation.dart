import 'package:flutter/material.dart';

/// Hard Level - Practical 1:
/// Create a Multi-step Form Wizard (Step 1: Personal Info, Step 2: Address,
/// Step 3: Review) with Navigator allowing forward/backward movement, validating each step.

class WizardData {
  String fullName = '';
  String email = '';
  String street = '';
  String city = '';
  String pincode = '';
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WizardStep1Screen(),
  ));
}

// ================= STEP 1: Personal Info =================
class WizardStep1Screen extends StatefulWidget {
  final WizardData? data;

  const WizardStep1Screen({super.key, this.data});

  @override
  State<WizardStep1Screen> createState() => _WizardStep1ScreenState();
}

class _WizardStep1ScreenState extends State<WizardStep1Screen> {
  final _formKey = GlobalKey<FormState>();
  late WizardData _wizardData;
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _wizardData = widget.data ?? WizardData();
    _nameController = TextEditingController(text: _wizardData.fullName);
    _emailController = TextEditingController(text: _wizardData.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _next() {
    if (_formKey.currentState!.validate()) {
      _wizardData.fullName = _nameController.text.trim();
      _wizardData.email = _emailController.text.trim();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WizardStep2Screen(data: _wizardData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wizard Step 1: Personal Info'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const LinearProgressIndicator(value: 0.33, color: Colors.indigo),
              const SizedBox(height: 24),
              const Text('Step 1 of 3: Personal Information',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
                validator: (val) => val == null || val.trim().isEmpty ? 'Please enter your full name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: 'Email Address', border: OutlineInputBorder()),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Please enter your email';
                  if (!val.contains('@') || !val.contains('.')) return 'Please enter a valid email';
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Next: Address Info'),
                onPressed: _next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= STEP 2: Address Info =================
class WizardStep2Screen extends StatefulWidget {
  final WizardData data;

  const WizardStep2Screen({super.key, required this.data});

  @override
  State<WizardStep2Screen> createState() => _WizardStep2ScreenState();
}

class _WizardStep2ScreenState extends State<WizardStep2Screen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _streetController;
  late TextEditingController _cityController;
  late TextEditingController _pincodeController;

  @override
  void initState() {
    super.initState();
    _streetController = TextEditingController(text: widget.data.street);
    _cityController = TextEditingController(text: widget.data.city);
    _pincodeController = TextEditingController(text: widget.data.pincode);
  }

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  void _next() {
    if (_formKey.currentState!.validate()) {
      widget.data.street = _streetController.text.trim();
      widget.data.city = _cityController.text.trim();
      widget.data.pincode = _pincodeController.text.trim();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WizardStep3Screen(data: widget.data),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wizard Step 2: Address Details'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const LinearProgressIndicator(value: 0.66, color: Colors.indigo),
              const SizedBox(height: 24),
              const Text('Step 2 of 3: Address & Location',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _streetController,
                decoration: const InputDecoration(labelText: 'Street Address', border: OutlineInputBorder()),
                validator: (val) => val == null || val.trim().isEmpty ? 'Enter street address' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City', border: OutlineInputBorder()),
                validator: (val) => val == null || val.trim().isEmpty ? 'Enter city' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pincodeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Postal PIN Code', border: OutlineInputBorder()),
                validator: (val) => val == null || val.trim().length < 4 ? 'Enter valid PIN Code' : null,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Next: Review'),
                      onPressed: _next,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= STEP 3: Review & Confirmation =================
class WizardStep3Screen extends StatelessWidget {
  final WizardData data;

  const WizardStep3Screen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wizard Step 3: Review & Submit'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LinearProgressIndicator(value: 1.0, color: Colors.green),
            const SizedBox(height: 24),
            const Text('Step 3 of 3: Summary Review',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _infoRow('Full Name', data.fullName),
                    _infoRow('Email Address', data.email),
                    const Divider(height: 24),
                    _infoRow('Street', data.street),
                    _infoRow('City', data.city),
                    _infoRow('PIN Code', data.pincode),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    icon: const Icon(Icons.check_circle),
                    label: const Text('Confirm & Finish'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Application Submitted!'),
                          content: Text('Thank you, ${data.fullName}! Wizard completed successfully.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                                Navigator.popUntil(context, (route) => route.isFirst);
                              },
                              child: const Text('Restart Wizard'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
