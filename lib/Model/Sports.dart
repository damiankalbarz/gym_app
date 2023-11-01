class Sports{
  final String id;
  final String className;
  final int maxUsers;
  final String startTime;
  final String endTime;
  final String dayOfWeek;

  Sports({required this.id, required this.className,required this.maxUsers,required this.startTime,required this.endTime,required this.dayOfWeek});

  factory Sports.fromJson(Map<String, dynamic> json){
    return Sports(id: json['id'],
        className: json['className'],
        maxUsers: json['maxUsers'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        dayOfWeek: json['dayOfWeek']);
  }
}