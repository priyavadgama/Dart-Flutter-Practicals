import 'package:flutter/material.dart';

/// Moderate Level - Practical 6:
/// Create a Login Form that shows an error message for wrong credentials
/// and navigates to HomeScreen for correct ones.

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q06LoginFormScreen(),
  ));
}

class Q06LoginFormScreen extends StatefulWidget {
  const Q06LoginFormScreen({super.key});

  @override
  State<Q06LoginFormScreen> createState() => _Q06LoginFormScreenState();
}

class _Q06LoginFormScreenState extends State<Q06LoginFormScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;

  // Correct credentials for testing
  final String _correctEmail = 'priya@admin.com';
  final String _correctPassword = 'password123';

  void _handleLogin() {
    final enteredEmail = _emailController.text.trim();
    final enteredPassword = _passwordController.text;

    if (enteredEmail == _correctEmail && enteredPassword == _correctPassword) {
      setState(() {
        _errorMessage = null;
      });
      // Navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginSuccessHomeScreen(userEmail: enteredEmail),
        ),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid email or password! Please check your credentials.';
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderate Q6: Login Form'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.lock_person, size: 72, color: Colors.deepPurple),
              const SizedBox(height: 16),
              const Text(
                'Student Portal Login',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade400),
                ),
                child: const Text(
                  'Demo Credentials:\nEmail: priya@admin.com\nPassword: password123',
                  style: TextStyle(fontSize: 12, color: Colors.brown),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.key),
                  border: OutlineInputBorder(),
                ),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.shade300),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.login),
                label: const Text('Login'),
                onPressed: _handleLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginSuccessHomeScreen extends StatelessWidget {
  final String userEmail;

  const LoginSuccessHomeScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Home'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.verified_user, size: 80, color: Colors.green),
              const SizedBox(height: 16),
              const Text('Authentication Successful!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Logged in as: $userEmail', style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white),
                icon: const Icon(Icons.logout),
                label: const Text('Log Out'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Q06LoginFormScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
