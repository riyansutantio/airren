import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CommonErrorView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CommonErrorView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CommonErrorView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
