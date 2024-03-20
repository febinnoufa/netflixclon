import 'dart:convert';

class TvSeriesModel {
    int page;
    List<Result> results;
    int totalPages;
    int totalResults;

    TvSeriesModel({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    TvSeriesModel copyWith({
        int? page,
        List<Result>? results,
        int? totalPages,
        int? totalResults,
    }) => 
        TvSeriesModel(
            page: page ?? this.page,
            results: results ?? this.results,
            totalPages: totalPages ?? this.totalPages,
            totalResults: totalResults ?? this.totalResults,
        );

    factory TvSeriesModel.fromRawJson(String str) => TvSeriesModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TvSeriesModel.fromJson(Map<String, dynamic> json) => TvSeriesModel(
        page: json["page"],
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class Result {
    bool adult;
    String backdropPath;
    int id;
    String name;
    OriginalLanguage originalLanguage;
    String originalName;
    String overview;
    String posterPath;
    MediaType mediaType;
    List<int> genreIds;
    double popularity;
    DateTime firstAirDate;
    double voteAverage;
    int voteCount;
    List<String> originCountry;

    Result({
        required this.adult,
        required this.backdropPath,
        required this.id,
        required this.name,
        required this.originalLanguage,
        required this.originalName,
        required this.overview,
        required this.posterPath,
        required this.mediaType,
        required this.genreIds,
        required this.popularity,
        required this.firstAirDate,
        required this.voteAverage,
        required this.voteCount,
        required this.originCountry,
    });

    Result copyWith({
        bool? adult,
        String? backdropPath,
        int? id,
        String? name,
        OriginalLanguage? originalLanguage,
        String? originalName,
        String? overview,
        String? posterPath,
        MediaType? mediaType,
        List<int>? genreIds,
        double? popularity,
        DateTime? firstAirDate,
        double? voteAverage,
        int? voteCount,
        List<String>? originCountry,
    }) => 
        Result(
            adult: adult ?? this.adult,
            backdropPath: backdropPath ?? this.backdropPath,
            id: id ?? this.id,
            name: name ?? this.name,
            originalLanguage: originalLanguage ?? this.originalLanguage,
            originalName: originalName ?? this.originalName,
            overview: overview ?? this.overview,
            posterPath: posterPath ?? this.posterPath,
            mediaType: mediaType ?? this.mediaType,
            genreIds: genreIds ?? this.genreIds,
            popularity: popularity ?? this.popularity,
            firstAirDate: firstAirDate ?? this.firstAirDate,
            voteAverage: voteAverage ?? this.voteAverage,
            voteCount: voteCount ?? this.voteCount,
            originCountry: originCountry ?? this.originCountry,
        );

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        id: json["id"],
        name: json["name"],
        originalLanguage: originalLanguageValues.map[json["original_language"]]!,
        originalName: json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        mediaType: mediaTypeValues.map[json["media_type"]]!,
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        firstAirDate: DateTime.parse(json["first_air_date"]),
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "name": name,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaTypeValues.reverse[mediaType],
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "popularity": popularity,
        "first_air_date": "${firstAirDate.year.toString().padLeft(4, '0')}-${firstAirDate.month.toString().padLeft(2, '0')}-${firstAirDate.day.toString().padLeft(2, '0')}",
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
    };
}

enum MediaType {
    TV
}

final mediaTypeValues = EnumValues({
    "tv": MediaType.TV
});

enum OriginalLanguage {
    DE,
    EN,
    ES
}

final originalLanguageValues = EnumValues({
    "de": OriginalLanguage.DE,
    "en": OriginalLanguage.EN,
    "es": OriginalLanguage.ES
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
