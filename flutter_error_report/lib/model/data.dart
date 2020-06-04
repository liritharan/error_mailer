import 'package:flutter/material.dart';

class Data {
  String transdesc;
  String transstatus;
  String transdatetime;

  Map<String, dynamic> toMap() {
    return {
      'transdesc': this.transdesc,
      'transstatus': this.transstatus,
      'transdatetime': this.transdatetime,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return new Data.name(
      transdesc: map['transdesc'] as String,
      transstatus: map['transstatus'] as String,
    );
  }

  Data(this.transdesc, this.transstatus) {
    this.transdatetime = DateTime.now().toIso8601String();
  }

  Data.name({
    @required this.transdesc,
    @required this.transstatus,
  }) {
    this.transdatetime = DateTime.now().toIso8601String();
  }
}
