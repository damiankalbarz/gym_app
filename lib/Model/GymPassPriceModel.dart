

class GymPassPrice{
  final String length;
  final double price;

  GymPassPrice({required this.length,required this.price});

  factory GymPassPrice.fromJson(Map<String, dynamic> json){
    return GymPassPrice(
      length: json['length'],
      price: json['price'],
    );
  }
}