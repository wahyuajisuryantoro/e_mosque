class SliderModel {
  final int no;
  final String name;
  final String link;
  final String description;
  final String url;
  final String urlText;
  final int number;
  final String picture;
  final DateTime date;
  final bool publish;

  SliderModel({
    required this.no,
    required this.name,
    required this.link,
    required this.description,
    required this.url,
    required this.urlText,
    required this.number,
    required this.picture,
    required this.date,
    required this.publish,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      no: int.parse(json['no']),
      name: json['name'],
      link: json['link'],
      description: json['description'],
      url: json['url'],
      urlText: json['url_text'],
      number: int.parse(json['number']),
      picture: json['picture'],
      date: DateTime.parse(json['date']),
      publish: json['publish'] == '1',
    );
  }
}
