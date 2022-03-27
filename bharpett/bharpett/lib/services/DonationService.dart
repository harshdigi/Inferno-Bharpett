import 'package:bharpett/models/DonationModel.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonationService {
  Dio dio = new Dio();
  var baseURL = "https://bharpett.herokuapp.com/api/";
  List<DonationModel> donationDataList = [];

  getallData(double lat, double long) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    dio.options.headers['authorization'] = "Bearer $token";
    baseURL = baseURL + "get_all_donation/";
    try {
      var response = await dio.post('$baseURL', data: {
        "latitude": lat,
        "longitude": long,
      });
      if (response.statusCode == 200) {
        print(response.data['results']);
        return response.data['results'];
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  getmyData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    dio.options.headers['authorization'] = "token $token";
    baseURL = baseURL + "get_my_donation/";
    try {
      var response =
          await dio.post('$baseURL', data: {"Authorization": '$token'});
      if (response.statusCode == 200) {
        print(response.data['results']);
        return response.data['results'];
      }
    } on DioError catch (e) {
      print(e);
    }
  }
}
