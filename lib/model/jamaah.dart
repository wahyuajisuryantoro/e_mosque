class Jamaah {
  final int no;
  final String username;
  final String subdomain;
  final String name;
  final String nik;
  final String link;
  final String birthPlace;
  final DateTime birthDate;
  final String sex;
  final String blood;
  final String marital;
  final String job;
  final String economicStatus;
  final String donatur;
  final String jamaahStatus;
  final String address;
  final String village;
  final String subdistrict;
  final String city;
  final String province;
  final String phone;
  final String email;
  final String picture;
  final DateTime date;
  final String publish;

  Jamaah({
    required this.no,
    required this.username,
    required this.subdomain,
    required this.name,
    required this.nik,
    required this.link,
    required this.birthPlace,
    required this.birthDate,
    required this.sex,
    required this.blood,
    required this.marital,
    required this.job,
    required this.economicStatus,
    required this.donatur,
    required this.jamaahStatus,
    required this.address,
    required this.village,
    required this.subdistrict,
    required this.city,
    required this.province,
    required this.phone,
    required this.email,
    required this.picture,
    required this.date,
    required this.publish,
  });

  factory Jamaah.fromJson(Map<String, dynamic> json) {
    return Jamaah(
      no: int.tryParse(json['no'].toString()) ?? 0,
      username: json['username'] ?? '',
      subdomain: json['subdomain'] ?? '',
      name: json['name'] ?? '',
      nik: json['nik'] ?? '',
      link: json['link'] ?? '',
      birthPlace: json['birth_place'] ?? '',
      birthDate: DateTime.parse(json['birth_date'] ?? '1970-01-01'),
      sex: json['sex'] ?? 'L',
      blood: json['blood'] ?? 'A',
      marital: json['marital'] ?? 'menikah',
      job: json['job'] ?? '',
      economicStatus: json['economic_status'] ?? 'mampu',
      donatur: json['donatur'] ?? '0',
      jamaahStatus: json['jamaah_status'] ?? 'jamaah',
      address: json['address'] ?? '',
      village: json['village'] ?? '',
      subdistrict: json['subdistrict'] ?? '',
      city: json['city'] ?? '',
      province: json['province'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      picture: json['picture'] ?? '',
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
      publish: json['publish'] ?? '1',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'no': no,
      'username': username,
      'subdomain': subdomain,
      'name': name,
      'nik': nik,
      'link': link,
      'birth_place': birthPlace,
      'birth_date': birthDate.toIso8601String(),
      'sex': sex,
      'blood': blood,
      'marital': marital,
      'job': job,
      'economic_status': economicStatus,
      'donatur': donatur,
      'jamaah_status': jamaahStatus,
      'address': address,
      'village': village,
      'subdistrict': subdistrict,
      'city': city,
      'province': province,
      'phone': phone,
      'email': email,
      'picture': picture,
      'date': date.toIso8601String(),
      'publish': publish,
    };
  }
}
