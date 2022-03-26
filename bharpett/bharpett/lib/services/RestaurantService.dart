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
        "latitude": 23.37498889,
        "longitude": 85.33548611,
      });
      if (response.statusCode == 200) {
        print(response.data['results']);
        return response.data['results'];
      }
    } on DioError catch (e) {
      print(e);
    }
  }
}
