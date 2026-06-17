import '../models/route_model.dart';

class GeminiService {
  Future<RouteModel> generateRoute() async {

    final json = {
      "routeName": "公園散歩ルート",
      "description": "公園を経由するルート",
      "spots": [
        {
          "name": "○○公園",
          "type": "park"
        },
        {
          "name": "△△神社",
          "type": "landmark"
        }
      ]
    };

    return RouteModel.fromJson(json);
  }
}
