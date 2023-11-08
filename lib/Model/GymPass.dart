

class GymPass {
  final String id;
  final String validTill;
  final String startedOn;
  final String qrCode;

  GymPass({required this.id, required this.validTill, required this.startedOn, required this.qrCode});

  factory GymPass.fromJson(Map<String,dynamic> json){
    return GymPass(
        id: json['id'],
        validTill: json['validTill'],
        startedOn: json['startedOn'],
        qrCode: json['qrCode']
    );
  }
}