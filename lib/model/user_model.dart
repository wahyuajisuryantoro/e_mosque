class User {
  final int userId;
  final String username;
  final String name;
  final String category;
  final String replika;
  final String referral;
  final String subdomain;
  final String link;
  final String numberId;
  final String birth;
  final String sex;
  final String address;
  final String city;
  final String phone;
  final String email;
  final String bankName;
  final String bankBranch;
  final String bankAccountNumber;
  final String bankAccountName;
  final String lastLogin;
  final String lastIpAddress;
  final String picture;
  final String date;
  final String publish;

  User({
    required this.userId,
    required this.username,
    required this.name,
    required this.category,
    required this.replika,
    required this.referral,
    required this.subdomain,
    required this.link,
    required this.numberId,
    required this.birth,
    required this.sex,
    required this.address,
    required this.city,
    required this.phone,
    required this.email,
    required this.bankName,
    required this.bankBranch,
    required this.bankAccountNumber,
    required this.bankAccountName,
    required this.lastLogin,
    required this.lastIpAddress,
    required this.picture,
    required this.date,
    required this.publish,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'], 
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? 'member',
      replika: json['replika'] ?? '',
      referral: json['referral'] ?? '',
      subdomain: json['subdomain'] ?? '',
      link: json['link'] ?? '',
      numberId: json['number_id'] ?? '',
      birth: json['birth'] ?? '',
      sex: json['sex'] ?? 'L',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      bankName: json['bank_name'] ?? '',
      bankBranch: json['bank_branch'] ?? '',
      bankAccountNumber: json['bank_account_number'] ?? '',
      bankAccountName: json['bank_account_name'] ?? '',
      lastLogin: json['last_login'] ?? '',
      lastIpAddress: json['last_ipaddress'] ?? '',
      picture: json['picture'] ?? '',
      date: json['date'] ?? '',
      publish: json['publish'] ?? '1',
    );
  }
   User copyWith({
    String? username,
    String? name,
    String? birth,
    String? sex,
    String? address,
    String? city,
    String? phone,
    String? email,
    String? bankName,
    String? bankBranch,
    String? bankAccountNumber,
    String? bankAccountName,
    String? picture,
  }) {
    return User(
      userId: userId,
      username: username ?? this.username,
      name: name ?? this.name,
      birth: birth ?? this.birth,
      sex: sex ?? this.sex,
      address: address ?? this.address,
      city: city ?? this.city,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      bankName: bankName ?? this.bankName,
      bankBranch: bankBranch ?? this.bankBranch,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      bankAccountName: bankAccountName ?? this.bankAccountName,
      picture: picture ?? this.picture,
      category: category,
      replika: replika,
      referral: referral,
      subdomain: subdomain,
      link: link,
      numberId: numberId,
      lastLogin: lastLogin,
      lastIpAddress: lastIpAddress,
      date: date,
      publish: publish,
    );
  }
}
