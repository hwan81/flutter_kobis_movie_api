import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:date_format/date_format.dart';

// https://www.kobis.or.kr/kobisopenapi/homepg/apiservice/searchServiceInfo.do?serviceId=searchDailyBoxOffice
class MovieApi {
  late final String dt;

  MovieApi({this.dt = ''}) {
    if (dt.length != 8) {
      var yesterday = DateTime.now().subtract(const Duration(days: 1));
      dt = formatDate(yesterday, [yyyy, mm, dd]);
    }
  }

  Future<List<dynamic>> getMoives() async {
    String key = 'f5eef3421c602c6cb7ea224104795888';
    String apiUrl =
        'http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?targetDt=$dt&key=$key';
    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<dynamic, dynamic> jsonData = jsonDecode(response.body);
      return jsonData['boxOfficeResult']['dailyBoxOfficeList'] as List<dynamic>;
      // print(jsonData);
    } else {
      // print('Error ${response.statusCode}');
      return [];
    }
  }
}
