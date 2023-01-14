class ShopLoginModel {
  late bool status;
  late String massage;
 late UserData data;
ShopLoginModel.fromjson(Map<String, dynamic> json)
{
 status = json['status'];
    massage = json['massage'];
    data = (json['data'] != null ? UserData.fromjson(json['data']) : null)!;


}


}

class UserData {
 late int id;
  late String email;
late  String phone;
 late String image;
  late String name;
 late int points;
  late int credit;
late  int token;
  UserData.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    name = json['name'];

    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
