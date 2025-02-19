import 'package:time_checker/components/constant.dart';
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
  final String? khayag;
  final int duuregId;
  final String? solongosNer;
  final double? urturug;
  final double? urgarag;
  final String? bairshil;
  final String? aOgnoo;
  final String? tOgnoo;
  final int? khesegBagId;
  final bool gerelsenu;
  final int irts;
  final Duureg duureg;

  Member({
    required this.id,
    required this.ner,
    required this.zurag,
    required this.khesegId,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    required this.utas,
    required this.khayag,
    required this.duuregId,
    this.solongosNer,
    this.urturug,
    this.urgarag,
    this.bairshil,
    this.aOgnoo,
    this.tOgnoo,
    this.khesegBagId,
    required this.gerelsenu,
    required this.irts,
    required this.duureg,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    try {
      loggerPretty.e("Parsing Member: $json");

      return Member(
        id: json['id'] ?? 0,
        ner: json['ner'] ?? "",
        zurag: json['zurag'],
        khesegId: json['kheseg_id'] ?? 0,
        createdAt: json['created_at'] ?? "",
        updatedAt: json['updated_at'] ?? "",
        code: json['code'] ?? "",
        utas: json['utas'],
        khayag: json['khayag'],
        duuregId: json['duureg_id'] ?? 0,
        solongosNer: json['solongos_ner'],
        urturug: json['urturug'] != null
            ? double.tryParse(json['urturug'].toString())
            : null,
        urgarag: json['urgarag'] != null
            ? double.tryParse(json['urgarag'].toString())
            : null,
        bairshil: json['bairshil'],
        aOgnoo: json['a_ognoo'],
        tOgnoo: json['t_ognoo'],
        khesegBagId: json['kheseg_bag_id'],
        gerelsenu: json['gerelsenu'].toString() == '1',
        irts: json['irts'] ?? 0,
        duureg: Duureg.fromJson(json['duureg']),
      );
    } catch (error) {
      loggerPretty.e("Error parsing Member: $error | JSON: $json");
      rethrow;
    }
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
      'urgarag': urgarag,
      'bairshil': bairshil,
      'a_ognoo': aOgnoo,
      't_ognoo': tOgnoo,
      'kheseg_bag_id': khesegBagId,
      'gerelsenu': gerelsenu ? 1 : 0,
      'irts': irts,
      'duureg': duureg.toJson(),
    };
  }
}
