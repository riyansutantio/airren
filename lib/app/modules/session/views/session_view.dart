import 'package:airen/app/modules/session/views/login_view.dart';
import 'package:airen/app/modules/session/views/otp_view.dart';
import 'package:airen/app/modules/session/views/payment_view.dart';
import 'package:airen/app/modules/session/views/register_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/session_controller.dart';

class SessionView extends GetView<SessionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SessionView'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Text(
              'SessionView is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.to(LoginView());
            },
            child: Center(
              child: Text(
                'login',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.to(RegisterView());
            },
            child: Center(
              child: Text(
                'register',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.to(OtpView());
            },
            child: Center(
              child: Text(
                'otp',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.to(PaymentView());
            },
            child: Center(
              child: Text(
                'paimin',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
