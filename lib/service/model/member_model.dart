import 'package:time_checker/service/model/duureg_model.dart';

class Member {
  final int id;
  final String ner;
  final String? zurag;
  final int khesegId;
  final String createdAt;
  final String updatedAt;
  final String code;
  final String utas;
  final String khayag;
  final int duuregId;
  final String? solongosNer;
  final double? urturug;
  final double? urgarg;
  final String? bairshil;
  final String aOgnoo;
  final String tOgnoo;
  final int? khesegBagId;
  final bool gerelsenu;
  final Duureg duureg;

  Member({
    required this.id,
    required this.ner,
    this.zurag,
    required this.khesegId,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    required this.utas,
    required this.khayag,
    required this.duuregId,
    this.solongosNer,
    this.urturug,
    this.urgarg,
    this.bairshil,
    required this.aOgnoo,
    required this.tOgnoo,
    this.khesegBagId,
    required this.gerelsenu,
    required this.duureg,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: int.tryParse(json['id'].toString()) ?? 0,
      ner: json['ner'],
      zurag: json['zurag'],
      khesegId: int.tryParse(json['kheseg_id'].toString()) ?? 0,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      code: json['code'],
      utas: json['utas'],
      khayag: json['khayag'],
      duuregId: int.tryParse(json['duureg_id'].toString()) ?? 0,
      solongosNer: json['solongos_ner'],
      urturug: json['urturug']?.toDouble(),
      urgarg: json['urgarag']?.toDouble(),
      bairshil: json['bairshil'],
      aOgnoo: json['a_ognoo'],
      tOgnoo: json['t_ognoo'],
      khesegBagId: json['kheseg_bag_id'] != null
          ? int.tryParse(json['kheseg_bag_id'].toString()) ?? 0
          : null,
      gerelsenu: json['gerelsenu'] == 1,
      duureg: Duureg.fromJson(json['duureg']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ner': ner,
      'zurag': zurag,
      'kheseg_id': khesegId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'code': code,
      'utas': utas,
      'khayag': khayag,
      'duureg_id': duuregId,
      'solongos_ner': solongosNer,
      'urturug': urturug,
      'urgarag': urgarg,
      'bairshil': bairshil,
      'a_ognoo': aOgnoo,
      't_ognoo': tOgnoo,
      'kheseg_bag_id': khesegBagId,
      'gerelsenu': gerelsenu ? 1 : 0,
      'duureg': duureg.toJson(),
    };
  }
}
