import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AboutUsView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AboutUsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AboutUsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
