
class Goal{
  final String content;
  bool finished;
  final String id;

  Goal({ required this.id,
    required this.content,
    required this.finished});
  
  factory Goal.fromJson(Map<String, dynamic> json){
    return Goal(
        id: json['id'],
        content: json['content'],
        finished: json['finished']) ;
  }
}