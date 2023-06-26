// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductsModel {
  bool couponStatus;
  String couponCode;
  num couponValue;
  String couponType;
  String id;
  String name;
  ProductsModel({
    required this.couponStatus,
    required this.couponCode,
    required this.couponValue,
    required this.couponType,
    required this.id,
    required this.name,
  });
 

  ProductsModel copyWith({
    bool? couponStatus,
    String? couponCode,
    num? couponValue,
    String? couponType,
    String? id,
    String? name,
  }) {
    return ProductsModel(
      couponStatus: couponStatus ?? this.couponStatus,
      couponCode: couponCode ?? this.couponCode,
      couponValue: couponValue ?? this.couponValue,
      couponType: couponType ?? this.couponType,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'couponStatus': couponStatus,
      'couponCode': couponCode,
      'couponValue': couponValue,
      'couponType': couponType,
      'id': id,
      'name': name,
    };
  }

  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      couponStatus: map['couponStatus'] as bool,
      couponCode: map['couponCode'] as String,
      couponValue: map['couponValue'] as num,
      couponType: map['couponType'] as String,
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductsModel.fromJson(String source) => ProductsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductsModel(couponStatus: $couponStatus, couponCode: $couponCode, couponValue: $couponValue, couponType: $couponType, id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ProductsModel &&
      other.couponStatus == couponStatus &&
      other.couponCode == couponCode &&
      other.couponValue == couponValue &&
      other.couponType == couponType &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode {
    return couponStatus.hashCode ^
      couponCode.hashCode ^
      couponValue.hashCode ^
      couponType.hashCode ^
      id.hashCode ^
      name.hashCode;
  }
}
