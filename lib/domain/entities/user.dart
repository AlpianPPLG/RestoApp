import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restoapp/domain/entities/enums.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// User entity representing a staff member.
@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required String username,
    required UserRole role,
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
