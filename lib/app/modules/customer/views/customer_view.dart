import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/customer_controller.dart';

class CustomerView extends GetView<CustomerController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomerView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CustomerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
