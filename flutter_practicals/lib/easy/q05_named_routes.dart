import 'package:flutter/material.dart';

/// Easy Level - Practical 5:
/// Create navigation between 3 screens (Home, About, Contact) using named routes.

void main() {
  runApp(const Q05NamedRoutesApp());
}

class Q05NamedRoutesApp extends StatelessWidget {
  const Q05NamedRoutesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const NamedHomeScreen(),
        '/about': (context) => const NamedAboutScreen(),
        '/contact': (context) => const NamedContactScreen(),
      },
    );
  }
}

class NamedHomeScreen extends StatelessWidget {
  const NamedHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Q5: Home Screen (Named Route: /)'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.home, size: 70, color: Colors.blueAccent),
              const SizedBox(height: 20),
              const Text('Home Screen', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.info_outline),
                label: const Text('Go to About (/about)'),
                onPressed: () => Navigator.pushNamed(context, '/about'),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.contact_mail_outlined),
                label: const Text('Go to Contact (/contact)'),
                onPressed: () => Navigator.pushNamed(context, '/contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NamedAboutScreen extends StatelessWidget {
  const NamedAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Screen (/about)'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.info, size: 70, color: Colors.teal),
              const SizedBox(height: 20),
              const Text('About This Application', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text(
                'This screen was pushed using Navigator.pushNamed(context, "/about").',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NamedContactScreen extends StatelessWidget {
  const NamedContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Screen (/contact)'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.contact_phone, size: 70, color: Colors.deepOrange),
              const SizedBox(height: 20),
              const Text('Contact Us', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text('Email: smit.kanojiya@example.com\nPhone: +91 98765 43210', textAlign: TextAlign.center),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
