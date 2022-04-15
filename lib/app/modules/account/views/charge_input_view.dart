import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ChargeInputView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChargeInputView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ChargeInputView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
