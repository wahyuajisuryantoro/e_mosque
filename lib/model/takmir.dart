class Takmir {
  final int no; // Primary key dari tabel
  final String username; // Username dari sesi login
  final String subdomain; // Subdomain masjid
  final String name; // Nama takmir
  final String link; // Link yang terkait dengan takmir
  final int noTakmirJabatan; // Foreign key yang menghubungkan ke tabel takmir_jabatan
  final String address; // Alamat takmir
  final String phone; // Nomor telepon takmir
  final String email; // Email takmir
  final String picture; // URL gambar takmir
  final DateTime date; // Tanggal pencatatan
  final String publish; // Status publikasi (1 atau 0)
  final String jabatan; // Nama jabatan dari tabel takmir_jabatan
  final String descriptionJabatan; // Deskripsi jabatan dari tabel takmir_jabatan

  Takmir({
    required this.no,
    required this.username,
    required this.subdomain,
    required this.name,
    required this.link,
    required this.noTakmirJabatan, // Relasi ke takmir_jabatan
    required this.address,
    required this.phone,
    required this.email,
    required this.picture,
    required this.date,
    required this.publish,
    required this.jabatan,
    required this.descriptionJabatan,
  });

  // Convert JSON to Takmir object
  factory Takmir.fromJson(Map<String, dynamic> json) {
    return Takmir(
      no: int.parse(json['no'].toString()), // Parsing integer untuk 'no'
      username: json['username'],
      subdomain: json['subdomain'],
      name: json['name'],
      link: json['link'],
      noTakmirJabatan: int.parse(json['no_takmir_jabatan'].toString()), // Parsing integer untuk 'no_takmir_jabatan'
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      picture: json['picture'] ?? '', // Handling null untuk picture
      date: DateTime.parse(json['date']), // Parsing DateTime
      publish: json['publish'],
      jabatan: json['jabatan'],
      descriptionJabatan: json['description_jabatan'],
    );
  }

  // Convert Takmir object to JSON
  Map<String, dynamic> toJson() {
    return {
      'no': no,
      'username': username,
      'subdomain': subdomain,
      'name': name,
      'link': link,
      'no_takmir_jabatan': noTakmirJabatan, // Foreign key ke takmir_jabatan
      'address': address,
      'phone': phone,
      'email': email,
      'picture': picture,
      'date': date.toIso8601String(), // Format DateTime ke ISO string
      'publish': publish,
      'jabatan': jabatan,
      'description_jabatan': descriptionJabatan,
    };
  }
}
