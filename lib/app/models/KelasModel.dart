// To parse this JSON data, do
//
//     final kelasModel = kelasModelFromJson(jsonString);

import 'dart:convert';

KelasModel kelasModelFromJson(String str) =>
    KelasModel.fromJson(json.decode(str));

String kelasModelToJson(KelasModel data) => json.encode(data.toJson());

class KelasModel {
  int id;
  String kodeKelas;
  String namaKelas;
  String jurusan;
  DateTime createdAt;
  DateTime updatedAt;

  KelasModel({
    required this.id,
    required this.kodeKelas,
    required this.namaKelas,
    required this.jurusan,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KelasModel.fromJson(Map<String, dynamic> json) => KelasModel(
        id: json["id"],
        kodeKelas: json["kode_kelas"],
        namaKelas: json["nama_kelas"],
        jurusan: json["jurusan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_kelas": kodeKelas,
        "nama_kelas": namaKelas,
        "jurusan": jurusan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
