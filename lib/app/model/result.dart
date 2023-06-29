class Result {

  final String name;
  final List<String> answers;

  Result({required this.name, required this.answers});

  Result.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        answers = json['results'].cast<String>();
}