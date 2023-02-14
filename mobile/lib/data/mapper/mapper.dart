import 'package:sed/app/constants.dart';
import 'package:sed/app/extensions.dart';
import 'package:sed/data/responses/responses.dart';
import 'package:sed/domain/model/models.dart';

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    // // since we did an extension why do we check again if it was null ?
    return Authentication(this?.token.orEmpty() ?? Constants.empty);
  }
}