import 'dart:convert';

class ProfileModel {
  final String company;
  final String website;
  final String phone;
  final String tagline;
  final String address;
  ProfileModel({
    required this.company,
    required this.website,
    required this.phone,
    required this.tagline,
    required this.address,
  });

  ProfileModel copyWith({
    String? company,
    String? website,
    String? phone,
    String? tagline,
    String? address,
  }) {
    return ProfileModel(
      company: company ?? this.company,
      website: website ?? this.website,
      phone: phone ?? this.phone,
      tagline: tagline ?? this.tagline,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'company': company,
      'website': website,
      'phone': phone,
      'tagline': tagline,
      'address': address,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      company: map['company'] ?? "",
      website: map['website'] ?? "",
      phone: map['phone'] ?? "",
      tagline: map['tagline'] ?? "",
      address: map['address'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProfileModel( company: $company, website: $website, phone: $phone, tagline: $tagline, address: $address)';
  }

  @override
  bool operator ==(covariant ProfileModel other) {
    if (identical(this, other)) return true;

    return other.company == company &&
        other.website == website &&
        other.phone == phone &&
        other.tagline == tagline &&
        other.address == address;
  }

  @override
  int get hashCode {
    return company.hashCode ^
        website.hashCode ^
        phone.hashCode ^
        tagline.hashCode ^
        address.hashCode;
  }
}
