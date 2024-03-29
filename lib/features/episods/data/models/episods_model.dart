import 'dart:math';

class EpisodsResult {
  final Info? info;
  final List<EpisodModel>? results;
  static List<String> episodsImages = [
    'assets/images/locations/location1.jpg',
    'assets/images/locations/location2.jpg',
    'assets/images/locations/location3.jpg',
    'assets/images/locations/location4.jpg',
    'assets/images/locations/location5.jpg',
    'assets/images/locations/location6.jpg',
  ];

  EpisodsResult({
    this.info,
    this.results,
  });

  factory EpisodsResult.fromJson(Map<String, dynamic> json) => EpisodsResult(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        results: json["results"] == null
            ? []
            : List<EpisodModel>.from(json["results"]!
                .map((episod) => EpisodModel.fromJson(episod, episodsImages))),
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

class EpisodModel {
  final int? id;
  final String? name;
  final String? airDate;
  final String? episode;
  final List<String>? characters;
  final String? url;
  final DateTime? created;
  final String? episodImage;

  EpisodModel({
    this.episodImage,
    this.id,
    this.name,
    this.airDate,
    this.episode,
    this.characters,
    this.url,
    this.created,
  });

  factory EpisodModel.fromJson(
    Map<String, dynamic> json,
    List<String>? episodsImages,
  ) =>
      EpisodModel(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
        characters: json["characters"] == null
            ? []
            : List<String>.from(json["characters"]!.map((x) => x)),
        url: json["url"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        episodImage: episodsImages![Random().nextInt(6)],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "air_date": airDate,
        "episode": episode,
        "characters": characters == null
            ? []
            : List<dynamic>.from(characters!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
      };
}
