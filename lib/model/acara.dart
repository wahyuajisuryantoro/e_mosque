class Acara {
  int no;
  String name;
  String description;
  DateTime dateStart;
  DateTime dateEnd;
  String location;
  String? speaker;
  String? organizer;
  String? image;
  String publish;
  DateTime? createdAt;
  DateTime? updatedAt;

  Acara({
    required this.no,
    required this.name,
    required this.description,
    required this.dateStart,
    required this.dateEnd,
    required this.location,
    this.speaker,
    this.organizer,
    this.image,
    required this.publish,
    this.createdAt,
    this.updatedAt,
  });

  factory Acara.fromJson(Map<String, dynamic> json) {
  return Acara(
    no: int.parse(json['no']),
    name: json['name'],
    description: json['description'],
    dateStart: DateTime.parse(json['date_start']),
    dateEnd: DateTime.parse(json['date_end']),
    location: json['location'],
    speaker: json['speaker'],
    organizer: json['organizer'],
    image: json['image'],
    publish: json['publish'],
    createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
  );
}


  Map<String, dynamic> toJson() {
    return {
      'no': no,
      'name': name,
      'description': description,
      'date_start': dateStart.toIso8601String(),
      'date_end': dateEnd.toIso8601String(),
      'location': location,
      'speaker': speaker,
      'organizer': organizer,
      'image': image,
      'publish': publish,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
