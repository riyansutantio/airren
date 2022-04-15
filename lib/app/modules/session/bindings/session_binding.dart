import 'package:airen/app/modules/session/providers/session_provider.dart';
import 'package:get/get.dart';

import '../controllers/session_controller.dart';

class SessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SessionController>(
      () => SessionController(sessionProvider: SessionProvider()),
    );
  }
}
