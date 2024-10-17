class Takmir {
  final int no;
  final String username;
  final String name;
  final String link;
  final int noTakmirJabatan;
  final String address;
  final String phone;
  final String? email;
  final String? picture; 
  final DateTime date;
  final String publish;
  final String? jabatan;

  Takmir({
    required this.no,
    required this.username,
    required this.name,
    required this.link,
    required this.noTakmirJabatan,
    required this.address,
    required this.phone,
    this.email,
    this.picture,
    required this.date,
    required this.publish,
    this.jabatan,
  });

  factory Takmir.fromJson(Map<String, dynamic> json) {
    return Takmir(
      no: int.tryParse(json['no'].toString()) ?? 0,
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      link: json['link'] ?? '',
      noTakmirJabatan: int.tryParse(json['no_takmir_jabatan'].toString()) ?? 0,
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'],
      picture: json['picture'], 
      date: DateTime.parse(json['date']),
      publish: json['publish'] ?? '1',
      jabatan: json['jabatan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'no': no,
      'username': username,
      'name': name,
      'link': link,
      'no_takmir_jabatan': noTakmirJabatan,
      'address': address,
      'phone': phone,
      'email': email,
      'picture': picture, 
      'date': date.toIso8601String(),
      'publish': publish,
      'jabatan': jabatan,
    };
  }
}
