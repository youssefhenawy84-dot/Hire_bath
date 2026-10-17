import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class Job {
  final String title;
  final String company;
  final int match;
  final List<String> missingSkills;

  const Job(this.title, this.company, this.match, this.missingSkills);
}

const jobs = [
  Job('Flutter Developer Intern', 'TechNile', 92, ['Firebase']),
  Job('Junior Data Analyst', 'DataWave', 78, ['SQL', 'Power BI']),
  Job('UI/UX Trainee', 'Pixel Studio', 65, ['Figma', 'Prototyping']),
];

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('HireBath')),
        body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: jobs.length,
          itemBuilder: (context, i) {
            final job = jobs[i];
            return Card(
              child: ListTile(
                title: Text(job.title),
                subtitle: Text(
                  '${job.company}\nMissing: ${job.missingSkills.join(', ')}',
                ),
                isThreeLine: true,
                    onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => JobDetailsScreen(job: job)),
  );
},
                trailing: Text(
  '${job.match}%',
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: job.match >= 85
        ? Colors.green
        : job.match >= 70
            ? Colors.orange
            : Colors.red,
  ),
),
                  
                  
                    
                  
                  
                
              ),
            );
          },
        ),
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
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: job.match / 100, minHeight: 10),
            const SizedBox(height: 24),
            const Text('Skills to learn:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: job.missingSkills
                  .map((s) => Chip(label: Text(s)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

