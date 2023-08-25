import 'wallet_model.dart';

class UserModel {
  String? userId, name, nickname, birth, phone, gender, email, picture,token;
  WalletModel? wallet;
  String get tokenUser => token ?? '';
  UserModel({
    this.userId,
    this.name,
    this.nickname,
    this.birth,
    this.phone,
    this.gender,
    this.email,
    this.picture,
    this.token,
    this.wallet,
  });

  UserModel.fromJson(Map<dynamic, dynamic> map, int val,{bool walletUser = false,bool noUser = true}) {
    if(walletUser == true) {
      wallet = WalletModel.fromJson(map['user']['walletes']);
    }
    if (map == null) return;
    if(noUser) {
      userId = map['user']['id'].toString();
      name = map['user']['name'];
      nickname = map['user']['nickname'];
      birth = map['user']['date_of_birthday'];
      phone = map['user']['phone_number'];
      gender = map['user']['gender'];
      email = map['user']['email'];
      picture = map['user']['image_link'];
      token = val == 0 ? '' : map['token']['token'];
      wallet = wallet;
    } else {
      userId = map['id'].toString();
      name = map['name'];
      nickname = map['nickname'];
      birth = map['date_of_birthday'];
      phone = map['phone_number'];
      gender = map['gender'];
      email = map['email'];
      picture = map['image_link'];
    }
    }

  toJson() {
    return {
      'userId': userId,
      'name': name,
      'nickname': nickname,
      'birth': birth,
      'phone': phone,
      'gender': gender,
      'email': email,
      'picture': picture,
      'token': token,
    };
  }
}
