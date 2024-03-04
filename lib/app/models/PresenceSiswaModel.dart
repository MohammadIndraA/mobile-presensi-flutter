// To parse this JSON data, do
//
//     final presenceSiswaModel = presenceSiswaModelFromJson(jsonString);

import 'dart:convert';

PresenceSiswaModel presenceSiswaModelFromJson(String str) =>
    PresenceSiswaModel.fromJson(json.decode(str));

String presenceSiswaModelToJson(PresenceSiswaModel data) =>
    json.encode(data.toJson());

class PresenceSiswaModel {
  int id;
  int userId;
  int guruId;
  int barcodeId;
  int mataPelajaranId;
  DateTime createdAt;
  DateTime updatedAt;
  MataPelajaran mataPelajaran;

  PresenceSiswaModel({
    required this.id,
    required this.userId,
    required this.guruId,
    required this.barcodeId,
    required this.mataPelajaranId,
    required this.createdAt,
    required this.updatedAt,
    required this.mataPelajaran,
  });

  factory PresenceSiswaModel.fromJson(Map<String, dynamic> json) =>
      PresenceSiswaModel(
        id: json["id"],
        userId: json["user_id"],
        guruId: json["guru_id"],
        barcodeId: json["barcode_id"],
        mataPelajaranId: json["mata_pelajaran_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        mataPelajaran: MataPelajaran.fromJson(json["mata_pelajaran"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "guru_id": guruId,
        "barcode_id": barcodeId,
        "mata_pelajaran_id": mataPelajaranId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "mata_pelajaran": mataPelajaran.toJson(),
      };
}

class MataPelajaran {
  int id;
  String kodePelajaran;
  String mataPelajaran;
  String hari;
  String jam;
  int kelasId;
  int guruId;
  DateTime createdAt;
  DateTime updatedAt;

  MataPelajaran({
    required this.id,
    required this.kodePelajaran,
    required this.mataPelajaran,
    required this.hari,
    required this.jam,
    required this.kelasId,
    required this.guruId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MataPelajaran.fromJson(Map<String, dynamic> json) => MataPelajaran(
        id: json["id"],
        kodePelajaran: json["kode_pelajaran"],
        mataPelajaran: json["mata_pelajaran"],
        hari: json["hari"],
        jam: json["jam"],
        kelasId: json["kelas_id"],
        guruId: json["guru_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_pelajaran": kodePelajaran,
        "mata_pelajaran": mataPelajaran,
        "hari": hari,
        "jam": jam,
        "kelas_id": kelasId,
        "guru_id": guruId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
