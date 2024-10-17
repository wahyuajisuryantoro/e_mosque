class TakmirJabatan {
  final int no;
  final String username;
  final String subdomain;
  final String name;
  final String link;
  final int level;
  final String description;
  final DateTime date;
  final String publish;

  TakmirJabatan({
    required this.no,
    required this.username,
    required this.subdomain,
    required this.name,
    required this.link,
    required this.level,
    required this.description,
    required this.date,
    required this.publish,
  });

  factory TakmirJabatan.fromJson(Map<String, dynamic> json) {
    return TakmirJabatan(
      no: int.tryParse(json['no'].toString()) ?? 0,
      username: json['username'] ?? '',
      subdomain: json['subdomain'] ?? '',
      name: json['name'] ?? '',
      link: json['link'] ?? '',
      level: int.tryParse(json['level'].toString()) ?? 0,
      description: json['description'] ?? '',
      date: DateTime.parse(json['date']),
      publish: json['publish'] ?? '1',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'no': no,
      'username': username,
      'subdomain': subdomain,
      'name': name,
      'link': link,
      'level': level,
      'description': description,
      'date': date.toIso8601String(),
      'publish': publish,
    };
  }
}
