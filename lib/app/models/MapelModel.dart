// To parse this JSON data, do
//
//     final mapelModel = mapelModelFromJson(jsonString);

import 'dart:convert';

MapelModel mapelModelFromJson(String str) =>
    MapelModel.fromJson(json.decode(str));

String mapelModelToJson(MapelModel data) => json.encode(data.toJson());

class MapelModel {
  int id;
  String kodePelajaran;
  String mataPelajaran;
  String hari;
  String jam;
  String kelasId;
  String guruId;
  DateTime createdAt;
  DateTime updatedAt;

  MapelModel({
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

  factory MapelModel.fromJson(Map<String, dynamic> json) => MapelModel(
        id: json["id"] ?? 0,
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
