class Berita {
  final int no;
  final String title;
  final String content;
  final String? image; 
  final DateTime date;
  final String author;
  final bool publish;
  final DateTime createdAt;
  final DateTime updatedAt;

  Berita({
    required this.no,
    required this.title,
    required this.content,
    this.image,
    required this.date,
    required this.author,
    required this.publish,
    required this.createdAt,
    required this.updatedAt,
  });

  
  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      no: int.parse(json['no']), 
      title: json['title'], 
      content: json['content'], 
      image: json['image'], 
      date: DateTime.parse(json['date']), 
      author: json['author'], 
      publish: json['publish'] == '1', 
      createdAt: DateTime.parse(json['created_at']), 
      updatedAt: DateTime.parse(json['updated_at']), 
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'no': no,
      'title': title,
      'content': content,
      'image': image,
      'date': date.toIso8601String(),
      'author': author,
      'publish': publish ? '1' : '0',
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
