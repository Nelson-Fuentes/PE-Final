import 'dart:core';

class Usuario {
  late String email;
  late String code;
  late String condition;
  late num latitude;
  late num longitude;
  late String phone;
  late String status;

  Usuario(this.email, this.code, this.condition, this.latitude, this.longitude,
      this.phone, this.status);
}
