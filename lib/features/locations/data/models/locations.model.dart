import 'dart:math';

class LocationsResult {
  final Info? info;
  final List<LocationModel>? results;
  static List<String> locationsImages = [
    'assets/images/locations/location1.jpg',
    'assets/images/locations/location2.jpg',
    'assets/images/locations/location3.jpg',
    'assets/images/locations/location4.jpg',
    'assets/images/locations/location5.jpg',
    'assets/images/locations/location6.jpg',
  ];

  LocationsResult({
    this.info,
    this.results,
  });

  factory LocationsResult.fromJson(Map<String, dynamic> json) =>
      LocationsResult(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        results: json["results"] == null
            ? []
            : List<LocationModel>.from(json["results"]!.map((location) =>
                LocationModel.fromJson(location, locationsImages))),
      );

  Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Info {
  final int? count;
  final int? pages;
  final String? next;
  final dynamic prev;

  Info({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
      };
}

class LocationModel {
  final int? id;
  final String? name;
  final String? type;
  final String? dimension;
  final List<String>? residents;
  final String? url;
  final DateTime? created;
  final String? locationImage;

  LocationModel({
    this.locationImage,
    this.id,
    this.name,
    this.type,
    this.dimension,
    this.residents,
    this.url,
    this.created,
  });

  factory LocationModel.fromJson(
          Map<String, dynamic> json, List<String> locationsImages) =>
      LocationModel(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        dimension: json["dimension"],
        residents: json["residents"] == null
            ? []
            : List<String>.from(json["residents"]!.map((x) => x)),
        url: json["url"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        locationImage: locationsImages[Random().nextInt(6)],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "dimension": dimension,
        "residents": residents == null
            ? []
            : List<dynamic>.from(residents!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
      };
}
