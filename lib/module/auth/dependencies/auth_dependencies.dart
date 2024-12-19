import 'package:get/get.dart';
import '../controller/AuthController.dart';
import '../infrastructure/auth_infrastructure.dart';

final kAuthController = Get.put(AuthController());
final kAuthInfrastructure = AuthInfrastructure();

