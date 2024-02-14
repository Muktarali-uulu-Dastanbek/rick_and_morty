// class CharactersResult {
//   // final String info;
//   final CharactersInfo2? info;
//   // final CharactersInfo? info;
//   // final List<CharacterResult>? results;

//   // CharactersResult({
//   //   // this.info,
//   //   // this.results,
//   // });
//   // CharactersResult();
//   CharactersResult({this.info});

//   // factory CharactersResult.fromJson(Map<String, dynamic> json) =>
//   factory CharactersResult.fromJson(dynamic json) => CharactersResult(
//         // "my-data",
//         info: null, //CharactersInfo2.fromJson(json["info"]),
//         // info: json["info"] == null ? null : CharactersInfo.fromJson(json["info"]),
//         // results: json["results"] == null
//         //     ? []
//         //     : List<CharacterResult>.from(
//         //         json["results"]!.map((x) => CharacterResult.fromJson(x))),
//       );

//   // Map<String, dynamic> toJson() => {
//   //   "info": info?.toJson(),
//   //   "results": results == null
//   //       ? []
//   //       : List<dynamic>.from(results!.map((x) => x.toJson())),
//   // };
// }

// class CharactersInfo2 {
//   final int? count;
//   CharactersInfo2({
//     this.count,
//   });
//   factory CharactersInfo2.fromJson(Map<String, dynamic> json) => CharactersInfo2(
//         count: json["count"],
//       );
// }

// class CharactersInfo {
//   final int? count;
//   // final int? pages;
//   // final String? next;
//   // final dynamic prev;

//   CharactersInfo({
//     this.count,
//     // this.pages,
//     // this.next,
//     // this.prev,
//   });

//   factory CharactersInfo.fromJson(Map<String, dynamic> json) => CharactersInfo(
//         count: json["count"],
//         // pages: json["pages"],
//         // next: json["next"],
//         // prev: json["prev"],
//       );

//   Map<String, dynamic> toJson() => {
//         "count": count,
//         // "pages": pages,
//         // "next": next,
//         // "prev": prev,
//       };
// }

// class CharacterResult {
//   final int? id;
//   // final String? name;
//   // final Status? status;
//   // final Species? species;
//   // final String? type;
//   // final Gender? gender;
//   // final Location? origin;
//   // final Location? location;
//   // final String? image;
//   // final List<String>? episode;
//   // final String? url;
//   // final DateTime? created;

//   CharacterResult({
//     this.id,
//     // this.name,
//     // this.status,
//     // this.species,
//     // this.type,
//     // this.gender,
//     // this.origin,
//     // this.location,
//     // this.image,
//     // this.episode,
//     // this.url,
//     // this.created,
//   });

//   factory CharacterResult.fromJson(Map<String, dynamic> json) => CharacterResult(
//         id: json["id"],
//         // name: json["name"],
//         // status: statusValues.map[json["status"]]!,
//         // species: speciesValues.map[json["species"]]!,
//         // type: json["type"],
//         // gender: genderValues.map[json["gender"]]!,
//         // origin:
//         //     json["origin"] == null ? null : Location.fromJson(json["origin"]),
//         // location: json["location"] == null
//         //     ? null
//         //     : Location.fromJson(json["location"]),
//         // image: json["image"],
//         // episode: json["episode"] == null
//         //     ? []
//         //     : List<String>.from(json["episode"]!.map((x) => x)),
//         // url: json["url"],
//         // created:
//         //     json["created"] == null ? null : DateTime.parse(json["created"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         // "name": name,
//         // "status": statusValues.reverse[status],
//         // "species": speciesValues.reverse[species],
//         // "type": type,
//         // "gender": genderValues.reverse[gender],
//         // "origin": origin?.toJson(),
//         // "location": location?.toJson(),
//         // "image": image,
//         // "episode":
//         //     episode == null ? [] : List<dynamic>.from(episode!.map((x) => x)),
//         // "url": url,
//         // "created": created?.toIso8601String(),
//       };
// }

// enum Gender { FEMALE, MALE, UNKNOWN }

// final genderValues = EnumValues(
//     {"Female": Gender.FEMALE, "Male": Gender.MALE, "unknown": Gender.UNKNOWN});

// class Location {
//   final String? name;
//   final String? url;

//   Location({
//     this.name,
//     this.url,
//   });

//   factory Location.fromJson(Map<String, dynamic> json) => Location(
//         name: json["name"],
//         url: json["url"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "url": url,
//       };
// }

// enum Species { ALIEN, HUMAN }

// final speciesValues =
//     EnumValues({"Alien": Species.ALIEN, "Human": Species.HUMAN});

// enum Status { ALIVE, DEAD, UNKNOWN }

// final statusValues = EnumValues(
//     {"Alive": Status.ALIVE, "Dead": Status.DEAD, "unknown": Status.UNKNOWN});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

//////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

// To parse this JSON data, do
//
//     final CharactersResult = CharactersResultFromJson(jsonString);

class CharactersResult {
  final CharactersInfo? info;
  final List<CharacterResult>? results;

  CharactersResult({
    this.info,
    this.results,
  });

  factory CharactersResult.fromJson(Map<String, dynamic> json) =>
      CharactersResult(
        info:
            json["info"] == null ? null : CharactersInfo.fromJson(json["info"]),
        results: json["results"] == null
            ? []
            : List<CharacterResult>.from(
                json["results"]!.map((x) => CharacterResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class CharactersInfo {
  final int? count;
  final int? pages;
  final String? next;
  final dynamic prev;

  CharactersInfo({
    this.count,
    this.pages,
    this.next,
    this.prev,
  });

  factory CharactersInfo.fromJson(Map<String, dynamic> json) => CharactersInfo(
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

class CharacterResult {
  final int? id;
  final String? name;
  final Status? status;
  final Species? species;
  final String? type;
  final Gender? gender;
  final Location? origin;
  final Location? location;
  final String? image;
  final List<String>? episode;
  final String? url;
  final DateTime? created;

  CharacterResult({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  factory CharacterResult.fromJson(Map<String, dynamic> json) =>
      CharacterResult(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]]!,
        species: speciesValues.map[json["species"]] ?? Species.UNKNOWN,
        type: json["type"],
        gender: genderValues.map[json["gender"]]!,
        origin:
            json["origin"] == null ? null : Location.fromJson(json["origin"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        image: json["image"],
        episode: json["episode"] == null
            ? []
            : List<String>.from(json["episode"]!.map((x) => x)),
        url: json["url"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": speciesValues.reverse[species],
        "type": type,
        "gender": genderValues.reverse[gender],
        "origin": origin?.toJson(),
        "location": location?.toJson(),
        "image": image,
        "episode":
            episode == null ? [] : List<dynamic>.from(episode!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
      };
}

enum Gender { FEMALE, MALE, UNKNOWN }

final genderValues = EnumValues(
    {"Female": Gender.FEMALE, "Male": Gender.MALE, "unknown": Gender.UNKNOWN});

class Location {
  final String? name;
  final String? url;

  Location({
    this.name,
    this.url,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

enum Species { ALIEN, HUMAN, UNKNOWN }

final speciesValues =
    EnumValues({"Alien": Species.ALIEN, "Human": Species.HUMAN});

enum Status { ALIVE, DEAD, UNKNOWN }

final statusValues = EnumValues(
    {"Alive": Status.ALIVE, "Dead": Status.DEAD, "unknown": Status.UNKNOWN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
