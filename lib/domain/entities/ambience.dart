class Ambience {
  final String id;
  final String title;
  final String tag;
  final int durationMinutes;
  final String description;
  final String thumbnailUrl;
  final String audioFileName;
  final List<String> sensoryChips;

  Ambience({
    required this.id,
    required this.title,
    required this.tag,
    required this.durationMinutes,
    required this.description,
    required this.thumbnailUrl,
    required this.audioFileName,
    required this.sensoryChips,
  });
}
