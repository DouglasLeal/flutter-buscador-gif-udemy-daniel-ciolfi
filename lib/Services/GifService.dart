import 'dart:convert';
import 'package:http/http.dart' as http;

class GifService{

  static String _trendingUrl = "https://api.giphy.com/v1/gifs/trending?api_key=DSp5yERyH8gxHR8FbH3enob08rEnob8p&limit=25&rating=r";
  static int offSet = 0;

  static Future<Map> get({search}) async {
    http.Response response;

    if(search == null){
      response = await http.get(Uri.parse(_trendingUrl));
    }else{
      response = await http.get(Uri.parse("https://api.giphy.com/v1/gifs/search?api_key=DSp5yERyH8gxHR8FbH3enob08rEnob8p&q=${search}&limit=20&offset=${offSet}&rating=r&lang=en"));
    }

    return json.decode(response.body);
  }
}