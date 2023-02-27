// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable() //json_serializable dependency
class BaseResponse {
  @JsonKey(name: "status") //this depend on the name in the API
  int? status; //this is the usable on the project
  @JsonKey(name: "message") //this depend on the name in the API
  String? message;
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "token")
  String? token;

  AuthenticationResponse(this.token);

  // From Json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  String? support;

  ForgotPasswordResponse(this.support);

  // From Json
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: "carousel")
  CarouselResponse carousel;

  @JsonKey(name: "categories")
  List<CategoriesResponse?> categories;

  HomeResponse(this.carousel, this.categories);

  // From Json
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

@JsonSerializable()
class CarouselResponse {
  @JsonKey(name: "Images")
  List<String?> images;

  CarouselResponse(this.images);

  // from json
  factory CarouselResponse.fromJson(Map<String, dynamic> json) =>
      _$CarouselResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$CarouselResponseToJson(this);
}

@JsonSerializable()
class CategoriesResponse {
  @JsonKey(name: "ID")
  int? id;

  @JsonKey(name: "Name")
  String? name;

  @JsonKey(name: "Image")
  String? image;

  CategoriesResponse(this.id, this.name, this.image);

  // from json
  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}
