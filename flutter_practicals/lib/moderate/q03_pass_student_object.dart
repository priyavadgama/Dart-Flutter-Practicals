import 'package:flutter/material.dart';

/// Moderate Level - Practical 3:
/// Pass data with navigation: send a Student object (name, roll no, marks)
/// from HomeScreen to DetailScreen and display it.

class Student {
  final String name;
  final int rollNumber;
  final double marks;

  const Student({
    required this.name,
    required this.rollNumber,
    required this.marks,
  });
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Q03StudentHomeScreen(),
  ));
}

class Q03StudentHomeScreen extends StatelessWidget {
  const Q03StudentHomeScreen({super.key});

  final List<Student> students = const [
    Student(name: 'Vadgama Priya Ashokbhai', rollNumber: 35, marks: 95.5),
    Student(name: 'Aarav Sharma', rollNumber: 22, marks: 88.0),
    Student(name: 'Priya Patel', rollNumber: 23, marks: 91.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moderate Q3: Student List'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo,
                child: Text('${student.rollNumber}', style: const TextStyle(color: Colors.white)),
              ),
              title: Text(student.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Score: ${student.marks}%'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigating and passing the Student object
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentDetailScreen(student: student),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class StudentDetailScreen extends StatelessWidget {
  final Student student;

  const StudentDetailScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${student.name}\'s Details'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.indigo,
                    child: Icon(Icons.person, size: 48, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    student.name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Divider(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Roll Number:', style: TextStyle(color: Colors.grey)),
                      Text('${student.rollNumber}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Academic Marks:', style: TextStyle(color: Colors.grey)),
                      Text('${student.marks}%', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Status:', style: TextStyle(color: Colors.grey)),
                      Text(student.marks >= 50 ? 'Passed with Distinction' : 'Needs Improvement',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: student.marks >= 50 ? Colors.blue : Colors.red,
                          )),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back to Student List'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
