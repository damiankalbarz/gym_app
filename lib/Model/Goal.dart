
class Goal{
  final String content;
  bool finished;

  Goal({required this.content, required this.finished});
  
  factory Goal.fromJson(Map<String, dynamic> json){
    return Goal(
        content: json['content'],
        finished: json['finshed']?? false) ;
  }
}