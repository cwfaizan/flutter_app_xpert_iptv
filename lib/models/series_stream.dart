class SeriesStream {
  final dynamic name;
  final dynamic seriesId;
  final dynamic cover;
  final dynamic plot;
  final dynamic cast;
  final dynamic director;
  final dynamic genre;
  final dynamic releaseDate;
  final dynamic lastModified;
  final dynamic rating;
  final dynamic rating5Based;
  final dynamic backdropPath;
  final dynamic youtubeTrailer;
  final dynamic episodeRunTime;
  final dynamic categoryId;

  SeriesStream({
    required this.name,
    required this.seriesId,
    required this.cover,
    required this.plot,
    required this.cast,
    required this.director,
    required this.genre,
    required this.releaseDate,
    required this.lastModified,
    required this.rating,
    required this.rating5Based,
    required this.backdropPath,
    required this.youtubeTrailer,
    required this.episodeRunTime,
    required this.categoryId,
  });

  factory SeriesStream.fromJson(Map<String, dynamic> json) => SeriesStream(
        name: json['name'],
        seriesId: json['series_id'],
        cover: json['cover'],
        plot: json['plot'],
        cast: json['cast'],
        director: json['director'],
        genre: json['genre'],
        releaseDate: json['releaseDate'],
        lastModified: json['last_modified'],
        rating: json['rating'],
        rating5Based: json['rating_5based'],
        backdropPath: json['backdrop_path'],
        youtubeTrailer: json['youtube_trailer'],
        episodeRunTime: json['episode_run_time'],
        categoryId: json['category_id'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'series_id': seriesId,
        'cover': cover,
        'plot': plot,
        'cast': cast,
        'director': director,
        'genre': genre,
        'releaseDate': releaseDate,
        'last_modified': lastModified,
        'rating': rating,
        'rating_5based': rating5Based,
        'backdrop_path': backdropPath,
        'youtube_trailer': youtubeTrailer,
        'episode_run_time': episodeRunTime,
        'category_id': categoryId,
      };
}
