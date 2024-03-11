import 'dart:convert';

import 'package:covid_app/Models/worldStats.dart';
import 'package:covid_app/services/utilities/App_url.dart';
import 'package:http/http.dart' as http;

class StatsService {
  Future<WorldStatsModel?> FetchWorldStatsRecord() async {
    var response = await http.get(Uri.parse(App_url.worldstatsApi));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return WorldStatsModel.fromJson(data);

      print(data);
    } else {
      print('Error feaching response');
    }
  }

  Future<List<dynamic>?> FetchCountryCases() async {
    var data;
    var response = await http.get(Uri.parse(App_url.countiresList));

    if (response.statusCode == 200) {
      data = json.decode(response.body);
      print(data);
      return data;
    } else {
      print('Error feaching response');
    }
  }
}
