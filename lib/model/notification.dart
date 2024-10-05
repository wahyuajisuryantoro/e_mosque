class NotificationModel {
  final int no;
  final String username;
  final String name;
  final String link;
  final String content;
  final String url;
  final String status;
  String? picture;
  final DateTime date;
  final bool publish;

  NotificationModel({
    required this.no,
    required this.username,
    required this.name,
    required this.link,
    required this.content,
    required this.url,
    required this.status,
    required this.picture,
    required this.date,
    required this.publish,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      no: json['no'] ?? 0,
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      link: json['link'] ?? '',
      content: json['content'] ?? '',
      url: json['url'] ?? '',
      status: json['status'] ?? 'unread',
      picture: json['picture'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime(1970, 1, 1),
      publish: json['publish'] == '1' ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'no': no,
      'username': username,
      'name': name,
      'link': link,
      'content': content,
      'url': url,
      'status': status,
      'picture': picture,
      'date': date.toIso8601String(),
      'publish': publish ? '1' : '0',
    };
  }
}
