import 'package:flutter/material.dart';

import '../util.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

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
