import 'dart:convert';

class Vouchers {
  int? id;
  String? kode;
  int? nominal;
  String? createdAt;
  String? updatedAt;

  Vouchers({
    this.id,
    this.kode,
    this.nominal,
    this.createdAt,
    this.updatedAt,
  });

  factory Vouchers.fromRawJson(String str) => Vouchers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Vouchers.fromJson(Map<String, dynamic> json) => Vouchers(
        id: json["id"],
        kode: json["kode"],
        nominal: json["nominal"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nominal": nominal,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
