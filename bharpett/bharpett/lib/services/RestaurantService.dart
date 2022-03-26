import 'package:bharpett/models/RestaurantModel.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantService {
  Dio dio = new Dio();
  var baseURL = "https://bharpett.herokuapp.com/api/get_all_restaurants/";
  List<RestuarantModel> restaurantDataList = [];

  getData(double lat, double long) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    dio.options.headers['authorization'] = "Bearer $token";
    try {
      var response = await dio.post('$baseURL', data: {
        "latitude": lat,
        "longitude": long,
      });
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
    }
  }
}
