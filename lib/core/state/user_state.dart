import 'package:flutter_application_1/data/repositories/user_repository.dart';
import 'package:flutter_application_1/data/models/output_utenza_dto.dart';

import 'package:flutter/foundation.dart';

class UserState extends ChangeNotifier {
  final UserRepository _repository;

  UserState(this._repository);

  OutputUtenzaDto? get currentUser => _repository.currentUser;
  void setUser(OutputUtenzaDto user) {
    _repository.setUser(user);
    notifyListeners();
  }

  void clearUser() {
    _repository.clearUser();
    notifyListeners();
  }
}
