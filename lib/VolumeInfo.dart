class VolumeInfo {
  final String? title;
  final List<String>? authors;
  final String? imageUrl;
  VolumeInfo({this.title, this.authors, this.imageUrl});
  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    return VolumeInfo(
      title: json['title'],
      authors: json['authors'] != null ? List<String>.from(json['authors']) : null,
      imageUrl: json['imageLinks'] != null ? json['imageLinks']['thumbnail'] : null,
    );
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['authors'] = authors;
    data['imageLinks'] = {'thumbnail': imageUrl};
    return data;
  }
}
