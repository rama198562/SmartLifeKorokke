class RouteSpot {
  final String name;
  final String type;

  RouteSpot({
    required this.name,
    required this.type,
  });

  factory RouteSpot.fromJson(Map<String, dynamic> json) {
    return RouteSpot(
      name: json['name'],
      type: json['type'],
    );
  }
}

class RouteModel {
  final String routeName;
  final String description;
  final List<RouteSpot> spots;

  RouteModel({
    required this.routeName,
    required this.description,
    required this.spots,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      routeName: json['routeName'],
      description: json['description'],
      spots: (json['spots'] as List)
          .map((e) => RouteSpot.fromJson(e))
          .toList(),
    );
  }
}
