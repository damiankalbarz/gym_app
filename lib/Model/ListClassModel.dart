class ListClassModel{
  final String id;
  final String className;
  final String startTime;
  final String endTime;
  final String dayOfWeek;
  final int ?maxUsers;
  final int ?usersCount;
  final String ?Trainer;

  ListClassModel(this.id, this.className, this.startTime, this.endTime,
      this.dayOfWeek, this.Trainer, this.maxUsers, this.usersCount);

  ListClassModel.two({required this.id,  required this.usersCount,  required this.maxUsers,required this.className, required this.startTime, required this.endTime,
      required this.dayOfWeek}): Trainer = null;

  factory ListClassModel.fromJson(Map<String, dynamic> json){
    return ListClassModel.two(
        id: json['id'],
        usersCount: json['usersCount'],
        maxUsers: json['maxUsers'],
        className: json['className'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        dayOfWeek: json['dayOfWeek']);
  }
}