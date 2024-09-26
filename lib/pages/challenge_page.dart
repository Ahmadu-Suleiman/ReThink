import 'package:flutter/material.dart';

class ChallengePage extends StatelessWidget {
  final List<String> dailyChallenges = [
    'Learn a new programming language',
    'Practice coding problems',
    'Read a book related to technology',
    'Exercise for 30 minutes',
    'Meditate for 15 minutes',
    'Call a friend or family member',
    'Try a new recipe',
    'Declutter a small area of your room',
    'Learn a new dance move',
    'Practice gratitude journaling',
  ];

  final List<DateTime> challengeDates = [
    DateTime.now().add(const Duration(days: 0)),
    DateTime.now().add(const Duration(days: 1)),
    DateTime.now().add(const Duration(days: 2)),
    DateTime.now().add(const Duration(days: 3)),
    DateTime.now().add(const Duration(days: 4)),
    DateTime.now().add(const Duration(days: 5)),
    DateTime.now().add(const Duration(days: 6)),
    DateTime.now().add(const Duration(days: 7)),
    DateTime.now().add(const Duration(days: 8)),
    DateTime.now().add(const Duration(days: 9)),
    // Add more dates as needed
  ];

  ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: dailyChallenges.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(child: Text('${challengeDates[index].day}')),
            title: Text(dailyChallenges[index]),
            subtitle: Text('${challengeDates[index].month}/${challengeDates[index].day}'),
          );
        },
      ),
    );
  }
}
