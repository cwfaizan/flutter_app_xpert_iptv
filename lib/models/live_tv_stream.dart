class LiveTvStream {
  final dynamic name;
  final dynamic streamType;
  final dynamic streamId;
  final dynamic streamIcon;
  final dynamic epgChannelId;
  final dynamic added;
  final dynamic isAdult;
  final dynamic categoryId;
  final dynamic customSid;
  final dynamic tvArchive;
  final dynamic directSource;
  final dynamic tvArchiveDuration;

  LiveTvStream({
    required this.name,
    required this.streamType,
    required this.streamId,
    required this.streamIcon,
    required this.epgChannelId,
    required this.added,
    required this.isAdult,
    required this.categoryId,
    required this.customSid,
    required this.tvArchive,
    required this.directSource,
    required this.tvArchiveDuration,
  });

  factory LiveTvStream.fromJson(Map<String, dynamic> json) => LiveTvStream(
        name: json['name'],
        streamType: json['stream_type'],
        streamId: json['stream_id'],
        streamIcon: json['stream_icon'],
        epgChannelId: json['epg_channel_id'],
        added: json['added'],
        isAdult: json['is_adult'],
        categoryId: json['category_id'],
        customSid: json['custom_sid'],
        tvArchive: json['tv_archive'],
        directSource: json['direct_source'],
        tvArchiveDuration: json['tv_archive_duration'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'stream_type': streamType,
        'stream_id': streamId,
        'stream_icon': streamIcon,
        'epg_channel_id': epgChannelId,
        'added': added,
        'is_adult': isAdult,
        'category_id': categoryId,
        'custom_sid': customSid,
        'tv_archive': tvArchive,
        'direct_source': directSource,
        'tv_archive_duration': tvArchiveDuration,
      };
}
