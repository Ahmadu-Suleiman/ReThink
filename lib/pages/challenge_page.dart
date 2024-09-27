import 'package:flutter/material.dart';

import '../util.dart';

class ChallengePage extends StatelessWidget {
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
            itemCount: Util.dailyChallenges.length,
            itemBuilder: (context, index) {
              DateTime date = DateTime.now().add(Duration(days: index));
              return ListTile(
                  leading: CircleAvatar(child: Text('${date.day}')),
                  title: Text(Util.dailyChallenges[index]),
                  subtitle: Text('${date.month}/${date.day}'));
            }));
  }
}
