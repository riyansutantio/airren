import 'package:flutter/material.dart';

import 'package:get/get.dart';

class TermConditionView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TermConditionView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TermConditionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
