class MoviesStream {
  final dynamic name;
  final dynamic streamType;
  final dynamic streamId;
  final dynamic streamIcon;
  final dynamic rating;
  final dynamic rating5Based;
  final dynamic added;
  final dynamic isAdult;
  final dynamic categoryId;
  final dynamic containerExtension;
  final dynamic customSid;
  final dynamic directSource;

  MoviesStream({
    required this.name,
    required this.streamType,
    required this.streamId,
    required this.streamIcon,
    required this.rating,
    required this.rating5Based,
    required this.added,
    required this.isAdult,
    required this.categoryId,
    required this.containerExtension,
    required this.customSid,
    required this.directSource,
  });

  factory MoviesStream.fromJson(Map<String, dynamic> json) => MoviesStream(
        name: json['name'],
        streamType: json['stream_type'],
        streamId: json['stream_id'],
        streamIcon: json['stream_icon'],
        rating: json['rating'],
        rating5Based: json['rating_5based'],
        added: json['added'],
        isAdult: json['is_adult'],
        categoryId: json['category_id'],
        containerExtension: json['container_extension'],
        customSid: json['custom_sid'],
        directSource: json['direct_source'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'stream_type': streamType,
        'stream_id': streamId,
        'stream_icon': streamIcon,
        'rating': rating,
        'rating_5based': rating5Based,
        'added': added,
        'is_adult': isAdult,
        'category_id': categoryId,
        'container_extension': containerExtension,
        'custom_sid': customSid,
        'direct_source': directSource,
      };
}
