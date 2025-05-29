// lib/features/auth/data/services/signup_service.dart

import 'package:app/services/api_service.dart';

class SignupService extends ApiService {
  SignupService() : super(baseUrl: 'http://127.0.0.1:8000/api/v1/register');
}
