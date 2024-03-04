// To parse this JSON data, do
//
//     final guruModel = guruModelFromJson(jsonString);

import 'dart:convert';

GuruModel guruModelFromJson(String str) => GuruModel.fromJson(json.decode(str));

String guruModelToJson(GuruModel data) => json.encode(data.toJson());

class GuruModel {
  int id;
  String kodeGuru;
  String nip;
  String namaGuru;
  String noWhatsapp;
  String alamatLengkap;
  String level;
  String jenisKelamin;
  String akunId;
  DateTime createdAt;
  DateTime updatedAt;

  GuruModel({
    required this.id,
    required this.kodeGuru,
    required this.nip,
    required this.namaGuru,
    required this.noWhatsapp,
    required this.alamatLengkap,
    required this.level,
    required this.jenisKelamin,
    required this.akunId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GuruModel.fromJson(Map<String, dynamic> json) => GuruModel(
        id: json["id"],
        kodeGuru: json["kode_guru"],
        nip: json["nip"],
        namaGuru: json["nama_guru"],
        noWhatsapp: json["no_whatsapp"],
        alamatLengkap: json["alamat_lengkap"],
        level: json["level"],
        jenisKelamin: json["jenis_kelamin"],
        akunId: json["akun_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_guru": kodeGuru,
        "nip": nip,
        "nama_guru": namaGuru,
        "no_whatsapp": noWhatsapp,
        "alamat_lengkap": alamatLengkap,
        "level": level,
        "jenis_kelamin": jenisKelamin,
        "akun_id": akunId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
