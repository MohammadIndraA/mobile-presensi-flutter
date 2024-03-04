// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int id;
  String nis;
  String namaLengkap;
  String noTelepon;
  String namaOrtu;
  String noTeleponOrtu;
  String alamatLengkap;
  String isAktip;
  String kelas;
  String jurusan;
  String akunId;
  String jenisKelamin;
  dynamic presensiId;
  dynamic emailVerifiedAt;
  String level;
  DateTime createdAt;
  DateTime updatedAt;

  UserModel({
    required this.id,
    required this.nis,
    required this.namaLengkap,
    required this.noTelepon,
    required this.namaOrtu,
    required this.noTeleponOrtu,
    required this.alamatLengkap,
    required this.isAktip,
    required this.kelas,
    required this.jurusan,
    required this.akunId,
    required this.jenisKelamin,
    required this.presensiId,
    required this.emailVerifiedAt,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        nis: json["nis"],
        namaLengkap: json["nama_lengkap"],
        noTelepon: json["no_telepon"],
        namaOrtu: json["nama_ortu"],
        noTeleponOrtu: json["no_telepon_ortu"],
        alamatLengkap: json["alamat_lengkap"],
        isAktip: json["is_aktip"],
        kelas: json["kelas"],
        jurusan: json["jurusan"],
        akunId: json["akun_id"],
        jenisKelamin: json["jenis_kelamin"],
        presensiId: json["presensi_id"],
        emailVerifiedAt: json["email_verified_at"],
        level: json["level"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nis": nis,
        "nama_lengkap": namaLengkap,
        "no_telepon": noTelepon,
        "nama_ortu": namaOrtu,
        "no_telepon_ortu": noTeleponOrtu,
        "alamat_lengkap": alamatLengkap,
        "is_aktip": isAktip,
        "kelas": kelas,
        "jurusan": jurusan,
        "akun_id": akunId,
        "jenis_kelamin": jenisKelamin,
        "presensi_id": presensiId,
        "email_verified_at": emailVerifiedAt,
        "level": level,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
