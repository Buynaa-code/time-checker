class Duureg {
  final int id;
  final String ner;
  final String createdAt;
  final String updatedAt;
  final int busId;

  Duureg({
    required this.id,
    required this.ner,
    required this.createdAt,
    required this.updatedAt,
    required this.busId,
  });

  factory Duureg.fromJson(Map<String, dynamic> json) {
    return Duureg(
      id: int.tryParse(json['id'].toString()) ?? 0,
      ner: json['ner'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      busId: int.tryParse(json['bus_id'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ner': ner,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'bus_id': busId,
    };
  }
}
