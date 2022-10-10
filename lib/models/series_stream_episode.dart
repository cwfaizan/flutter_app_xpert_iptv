class SeriesStreamEpisode {
  final dynamic id;
  final dynamic title;
  final dynamic containerExtension;
  final dynamic plot;
  final dynamic duration;
  final dynamic movieImage;
  final dynamic seasonsNo;

  SeriesStreamEpisode({
    required this.id,
    required this.title,
    required this.containerExtension,
    required this.plot,
    required this.duration,
    required this.movieImage,
    required this.seasonsNo,
  });

  factory SeriesStreamEpisode.fromJson(Map<String, dynamic> json) =>
      SeriesStreamEpisode(
        id: json['id'],
        title: json['title'],
        containerExtension: json['container_extension'],
        plot: json['info']['plot'],
        duration: json['info']['duration'],
        movieImage: json['info']['movie_image'],
        seasonsNo: json['seasons_no'],
      );
}
