import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Hard Level - Practical 10:
/// Build a Multi-user Login System using Provider and Form validation together,
/// where a `List<User>` is stored in Provider and the Login screen validates against that list.

class User {
  final String email;
  final String password;
  final String role;
  final String displayName;

  const User({
    required this.email,
    required this.password,
    required this.role,
    required this.displayName,
  });
}

class UserManagementProvider extends ChangeNotifier {
  final List<User> _registeredUsers = [
    const User(email: 'priya@admin.com', password: 'admin123', role: 'System Administrator', displayName: 'Vadgama Priya Ashokbhai'),
    const User(email: 'alex@student.com', password: 'alexpass', role: 'Research Scholar', displayName: 'Alex Rivera'),
    const User(email: 'priya@faculty.com', password: 'priyapass', role: 'Senior Professor', displayName: 'Prof. Priya Mehta'),
  ];

  User? _currentUser;

  List<User> get users => List.unmodifiable(_registeredUsers);
  User? get currentUser => _currentUser;

  bool authenticate(String email, String password) {
    try {
      final user = _registeredUsers.firstWhere(
        (u) => u.email.toLowerCase() == email.trim().toLowerCase() && u.password == password,
      );
      _currentUser = user;
      notifyListeners();
      return true;
    } catch (_) {
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  void registerUser(User newUser) {
    _registeredUsers.add(newUser);
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserManagementProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Q10MultiUserLoginScreen(),
      ),
    ),
  );
}

class Q10MultiUserLoginScreen extends StatefulWidget {
  const Q10MultiUserLoginScreen({super.key});

  @override
  State<Q10MultiUserLoginScreen> createState() => _Q10MultiUserLoginScreenState();
}

class _Q10MultiUserLoginScreenState extends State<Q10MultiUserLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'priya@admin.com');
  final _passwordController = TextEditingController(text: 'admin123');
  bool _obscure = true;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<UserManagementProvider>();
      final isSuccess = authProvider.authenticate(
        _emailController.text,
        _passwordController.text,
      );

      if (isSuccess) {
        setState(() => _errorMessage = null);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => ChangeNotifierProvider.value(
              value: authProvider,
              child: const UserDashboardScreen(),
            ),
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'Invalid email or password. Verify against registered Provider users list!';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManagementProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hard Q10: Multi-User Provider Auth'),
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
                const Icon(Icons.security, size: 70, color: Colors.indigo),
                const SizedBox(height: 12),
                const Text(
                  'Multi-User Authentication',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // Registered users preview card
                Consumer<UserManagementProvider>(
                  builder: (context, provider, child) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.indigo.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Available Accounts in Provider:',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.indigo)),
                          const SizedBox(height: 4),
                          ...provider.users.map((u) => Text('• ${u.email} (Pass: ${u.password}) [${u.role}]',
                              style: const TextStyle(fontSize: 11))),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'User Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) return 'Email is required';
                    if (!val.contains('@')) return 'Enter valid email address';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  validator: (val) => val == null || val.isEmpty ? 'Password is required' : null,
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade300),
                    ),
                    child: Text(_errorMessage!, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  ),
                ],
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: const Icon(Icons.login),
                  label: const Text('Validate & Login'),
                  onPressed: _onLoginPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserManagementProvider>();
    final user = userProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Authorized Dashboard'),
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 44,
                backgroundColor: Colors.green,
                child: Icon(Icons.check_circle, size: 54, color: Colors.white),
              ),
              const SizedBox(height: 18),
              Text(
                'Welcome, ${user?.displayName ?? "User"}!',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Role: ${user?.role ?? "Standard User"}',
                  style: TextStyle(fontSize: 16, color: Colors.green.shade900, fontWeight: FontWeight.bold)),
              Text('Email: ${user?.email ?? ""}', style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
                icon: const Icon(Icons.logout),
                label: const Text('Sign Out'),
                onPressed: () {
                  userProvider.logout();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
