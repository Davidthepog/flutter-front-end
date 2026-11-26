import 'package:flutter_application_1/data/models/output_utenza_dto.dart';

class UserRepository {
  OutputUtenzaDto? _currentUser;

  OutputUtenzaDto? get currentUser => _currentUser;

  void setUser(OutputUtenzaDto user) {
    _currentUser = user;
  }

  void clearUser() {
    _currentUser = null;
  }
}
