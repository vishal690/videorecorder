import 'package:videorecorder/utils/HttpClintHelper.dart';
import 'package:videorecorder/utils/UrlConfig.dart';
import 'global_data.dart';

void apiLogger(String content) async {
  String url = UrlConfig.TimeClickURL + "/" + GlobalData.token + "/" + content;
  print(url);
  var response =
      await HttpClientHelper.Get(url, contentType: ContentType.string);
  print(response);
}
