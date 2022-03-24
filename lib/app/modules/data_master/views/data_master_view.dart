import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/data_master_controller.dart';

class DataMasterView extends GetView<DataMasterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DataMasterView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DataMasterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
