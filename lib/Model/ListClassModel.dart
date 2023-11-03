class ListClassModel{
  final String id;
  final String className;
  final String startTime;
  final String endTime;
  final String dayOfWeek;
  final String ?Trainer;

  ListClassModel(this.id, this.className, this.startTime, this.endTime,
      this.dayOfWeek, this.Trainer);

  ListClassModel.two({required this.id,required this.className, required this.startTime, required this.endTime,
      required this.dayOfWeek}): Trainer = null;

  factory ListClassModel.fromJson(Map<String, dynamic> json){
    return ListClassModel.two(
        id: json['id'],
        className: json['className'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        dayOfWeek: json['dayOfWeek']);
  }
}