class Masjid {
  final int userId;
  final String username;
  final String subdomain;
  final String name;
  final String link;
  final String content;
  final String address;
  final String city;
  final String maps;
  final String phone;
  final String email;
  final int luasTanah;
  final int luasBangunan;
  final String statusTanah;
  final int tahunBerdiri;
  final String legalitas;
  final String facebook;
  final String twitter;
  final String instagram;
  final String youtube;
  final String tiktok;
  String? picture;
  final DateTime date;
  final bool publish;

  Masjid({
    required this.userId,
    required this.username,
    required this.subdomain,
    required this.name,
    required this.link,
    required this.content,
    required this.address,
    required this.city,
    required this.maps,
    required this.phone,
    required this.email,
    required this.luasTanah,
    required this.luasBangunan,
    required this.statusTanah,
    required this.tahunBerdiri,
    required this.legalitas,
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.youtube,
    required this.tiktok,
    required this.picture,
    required this.date,
    required this.publish,
  });

  
  factory Masjid.fromJson(Map<String, dynamic> json) {
    return Masjid(
      userId: json['user_id'] ?? 0, 
      username: json['username'] ?? '', 
      subdomain: json['subdomain'] ?? '',
      name: json['name'] ?? '',
      link: json['link'] ?? '',
      content: json['content'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      maps: json['maps'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      luasTanah: json['luas_tanah'] ?? 0, 
      luasBangunan: json['luas_bangunan'] ?? 0, 
      statusTanah: json['status_tanah'] ?? '',
      tahunBerdiri: json['tahun_berdiri'] ?? 0, 
      legalitas: json['legalitas'] ?? '',
      facebook: json['facebook'] ?? '',
      twitter: json['twitter'] ?? '',
      instagram: json['instagram'] ?? '',
      youtube: json['youtube'] ?? '',
      tiktok: json['tiktok'] ?? '',
      picture: json['picture'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime(1970, 1, 1), 
      publish: json['publish'] == '1' ? true : false, 
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'subdomain': subdomain,
      'name': name,
      'link': link,
      'content': content,
      'address': address,
      'city': city,
      'maps': maps,
      'phone': phone,
      'email': email,
      'luas_tanah': luasTanah,
      'luas_bangunan': luasBangunan,
      'status_tanah': statusTanah,
      'tahun_berdiri': tahunBerdiri,
      'legalitas': legalitas,
      'facebook': facebook,
      'twitter': twitter,
      'instagram': instagram,
      'youtube': youtube,
      'tiktok': tiktok,
      'picture': picture,
      'date': date.toIso8601String(), 
      'publish': publish ? '1' : '0', 
    };
  }
}
