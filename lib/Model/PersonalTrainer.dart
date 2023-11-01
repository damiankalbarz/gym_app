import 'Sports.dart';

class PersonalTrainer{
  final String name;
  final String surname;
  final String email;
  final List<Sports> sports;

  PersonalTrainer({required this.name,
    required this.surname,
    required this.email,
    required this.sports});

  factory PersonalTrainer.fromJson(Map<String, dynamic> json){
    var sportsList = json['classes'] as List;
    List<Sports> classes = sportsList.map((i) => Sports.fromJson(i)).toList();
    return PersonalTrainer(name: json['name'],
        surname: json['surname'],
        email: json['email'],
        sports: classes);
  }
}