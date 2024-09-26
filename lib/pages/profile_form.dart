import 'package:flutter/material.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final formKey = GlobalKey<FormState>();
  final controllerName = TextEditingController();
  final controllerLocation = TextEditingController();
  final controllerPreferences = TextEditingController();
  final controllerChallenges = TextEditingController();
  bool wasteReduction = false;
  bool energyConservation = false;
  bool ethicalConsumption = false;
  final String otherInterests = '';
  final String reduceWasteGoal = '';
  final String conserveEnergyGoal = '';
  bool beginner = false;
  bool intermediate = false;
  bool advanced = false;
  bool dailyCommitment = false;
  bool weeklyCommitment = false;
  bool monthlyCommitment = false;
  final String timeCommitmentFrequency = '';
  final String additionalPreferences = '';
  final String challenges = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: formKey,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      const Text("Let's create your profile first!",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextFormField(
                          controller: controllerName,
                          decoration: const InputDecoration(labelText: 'Name'),
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter your name' : null),
                      TextFormField(
                          controller: controllerLocation,
                          decoration:
                              const InputDecoration(labelText: 'Location'),
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your Country'
                              : null),
                      const SizedBox(height: 20),
                      const Text('Sustainability Interests:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      CheckboxListTile(
                          value: wasteReduction,
                          onChanged: (bool? value) {
                            setState(() => wasteReduction = value!);
                          },
                          title: const Text('Waste Reduction')),
                      CheckboxListTile(
                          value: energyConservation,
                          onChanged: (bool? value) {
                            setState(() => energyConservation = value!);
                          },
                          title: const Text('Energy Conservation')),
                      CheckboxListTile(
                          value: ethicalConsumption,
                          onChanged: (bool? value) {
                            setState(() => ethicalConsumption = value!);
                          },
                          title: const Text('Ethical Consumption')),
                      TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Other Interests'),
                          maxLines: null),
                      const SizedBox(height: 20),
                      const Text('Goals:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Reduce waste by'),
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your waste reduction goal'
                              : null),
                      TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Conserve energy by'),
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your energy conservation goal'
                              : null),
                      TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Other goals'),
                          maxLines: null),
                      const SizedBox(height: 20),
                      const Text('Time Commitment:',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      CheckboxListTile(
                          value: dailyCommitment,
                          onChanged: (bool? value) {
                            setState(() => dailyCommitment = value!);
                          },
                          title: const Text('Daily')),
                      CheckboxListTile(
                          value: weeklyCommitment,
                          onChanged: (bool? value) {
                            setState(() => weeklyCommitment = value!);
                          },
                          title: const Text('Weekly')),
                      CheckboxListTile(
                          value: monthlyCommitment,
                          onChanged: (bool? value) {
                            setState(() => monthlyCommitment = value!);
                          },
                          title: const Text('Monthly')),
                      const SizedBox(height: 20),
                      const Text('Additional Information (Optional):',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      TextFormField(
                          controller: controllerPreferences,
                          decoration:
                              const InputDecoration(labelText: 'Preferences'),
                          maxLines: null),
                      TextFormField(
                          controller: controllerChallenges,
                          decoration:
                              const InputDecoration(labelText: 'Challenges'),
                          maxLines: null),
                      const SizedBox(height: 16),
                      ElevatedButton(
                          child: const Text('Submit'),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {}
                          })
                    ])))));
  }

  String preparePrompt() {
    Map<String, dynamic> userData = {
      'name': controllerName.text,
      'location': controllerLocation.text,
      'wasteReduction': wasteReduction ? 'Yes' : 'No',
      'energyConservation': energyConservation ? 'Yes' : 'No',
      'ethicalConsumption': ethicalConsumption ? 'Yes' : 'No',
      'otherInterests': otherInterests,
      'reduceWasteGoal': reduceWasteGoal,
      'conserveEnergyGoal': conserveEnergyGoal,
      'dailyCommitment': dailyCommitment ? 'Yes' : 'No',
      'weeklyCommitment': weeklyCommitment ? 'Yes' : 'No',
      'monthlyCommitment': monthlyCommitment ? 'Yes' : 'No',
      'preferences': additionalPreferences,
      'challenges': challenges,
    };

    String prompt = '''
    User Profile:
    
    Name: ${userData['name']}
    Location: ${userData['location']}
    
    Sustainability Interests:
    Waste Reduction: ${userData['wasteReduction']}
    Energy Conservation: ${userData['energyConservation']}
    Ethical Consumption: ${userData['ethicalConsumption']}
    Other Interests: ${userData['otherInterests']}
    
    Goals:
    Reduce waste by: ${userData['reduceWasteGoal']}
    Conserve energy by: ${userData['conserveEnergyGoal']}
    Other goals: ${userData['otherInterests']}
    
    Time Commitment:
    Daily: ${userData['dailyCommitment']}
    Weekly: ${userData['weeklyCommitment']}
    Monthly: ${userData['monthlyCommitment']}
    
    Preferences: ${userData['preferences']}
    Challenges: ${userData['challenges']}
    
    Please analyze this user profile and generate 30 comma separated daily 
    challenges based on their sustainability interests, goals, and overall 
    approach to environmental responsibility.
    ''';
    return prompt;
  }
}
