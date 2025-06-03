class MusicaModel {
  String title;
  String author;
  String url;
  double duration;

  MusicaModel({
    required this.title,
    required this.author,
    required this.url,
    required this.duration,
  });

  factory MusicaModel.fromJson(Map<String, dynamic> json) {
    String durationStr = json['duration'] as String;
    List<String> parts = durationStr.split(':');
    double durationInSeconds = 0;
    if (parts.length == 2) {
      int minutes = int.tryParse(parts[0]) ?? 0;
      int seconds = int.tryParse(parts[1]) ?? 0;
      durationInSeconds = (minutes * 60 + seconds).toDouble();
    }
    return MusicaModel(
      title: json['title'] as String,
      author: json['author'] as String,
      url: json['url'] as String,
      duration: durationInSeconds,
    );
  }
}