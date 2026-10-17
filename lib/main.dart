import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

// مهارات الطالب - غيّرها وشوف النسب بتتغير
const studentSkills = ['Flutter', 'Dart', 'Python', 'Git'];

class Job {
  final String title;
  final String company;
  final List<String> requiredSkills;

  const Job(this.title, this.company, this.requiredSkills);

  List<String> get missingSkills =>
      requiredSkills.where((s) => !studentSkills.contains(s)).toList();

  int get match {
    final matched = requiredSkills.length - missingSkills.length;
    return (matched * 100 / requiredSkills.length).round();
  }
}

const jobs = [
  Job('Flutter Developer Intern', 'TechNile',
      ['Flutter', 'Dart', 'Git', 'Firebase']),
  Job('Junior Data Analyst', 'DataWave', ['Python', 'Git', 'SQL']),
  Job('UI/UX Trainee', 'Pixel Studio', ['Figma', 'Prototyping', 'Dart']),
];

Color matchColor(int match) {
  if (match >= 75) return Colors.green;
  if (match >= 50) return Colors.orange;
  return Colors.red;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HireBath'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: jobs.length,
        itemBuilder: (context, i) {
          final job = jobs[i];
          final missing = job.missingSkills;
          return Card(
            child: ListTile(
              title: Text(job.title),
              subtitle: Text(
                '${job.company}\n'
                '${missing.isEmpty ? 'No missing skills' : 'Missing: ${missing.join(', ')}'}',
              ),
              isThreeLine: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JobDetailsScreen(job: job),
                  ),
                );
              },
              trailing: Text(
                '${job.match}%',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: matchColor(job.match),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class JobDetailsScreen extends StatelessWidget {
  final Job job;
  const JobDetailsScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(job.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.company, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Match: ${job.match}%',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: matchColor(job.match))),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: job.match / 100, minHeight: 10),
            const SizedBox(height: 24),
            const Text('Required skills:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: job.requiredSkills
                  .map((s) => Chip(
                        label: Text(s),
                        backgroundColor: studentSkills.contains(s)
                            ? Colors.green.shade100
                            : Colors.red.shade100,
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            const Text('Green = you have it, Red = skill to learn'),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('My Skills',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children:
                  studentSkills.map((s) => Chip(label: Text(s))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}