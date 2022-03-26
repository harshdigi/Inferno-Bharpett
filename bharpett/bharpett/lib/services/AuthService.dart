import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Dio dio = new Dio();
  var baseURL = "https://bharpett.herokuapp.com/accounts/register/";

  createUser(String name, String email, String password, String phone,
      String role) async {
    try {
      var response = await dio.post(
        "https://bharpett.herokuapp.com/accounts/register/",
        data: {
          "fullname": name,
          "email": email,
          "password": password,
          "role": role,
          "phone": phone
        },
      );
      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        print(response.data['error']);
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  loginUser(String email, String password) async {
    try {
      var response = await dio.post(
        "https://bharpett.herokuapp.com/accounts/login/",
        data: {"email": email, "password": password},
      );
      if (response.statusCode == 200) {
        print(response.data);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString('token', response.data['message']['token']);
        return response.data;
      } else {
        print(response.data['error']);
      }
    } on DioError catch (e) {
      print(e);
    }
  }
}
