import 'dart:convert';

import 'package:new_project/Models/Services/Utility/app_url.dart';
import 'package:new_project/Models/world_status_model.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<WorldStatusModel> fetchWorldStatusData() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatusUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatusModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> fetchCountriesStatusData()async{
    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesStatusUrl));
    if(response.statusCode == 200){
      data = jsonDecode(response.body);
      print(response.statusCode);

      return data;
    }else{
      throw Exception("Error");
    }
  }
}
