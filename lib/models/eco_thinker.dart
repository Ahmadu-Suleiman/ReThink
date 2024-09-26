class EcoThinker {
  EcoThinker({required this.name, required this.challenges});

  final String name;
  final List<String> challenges;

  Map<String, dynamic> toJson() => {
        'name': name,
        'challenges': challenges,
      };

  factory EcoThinker.fromJson(Map<String, dynamic> json) => EcoThinker(
      name: json['name'], challenges: List<String>.from(json['challenges']));
}
