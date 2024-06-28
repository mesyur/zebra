// ignore_for_file: public_member_api_docs, sort_constructors_first
class CheckLoginCodeRequestDto {
  final int pin;
  final int userId;

  CheckLoginCodeRequestDto({
    required this.pin,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'pin': pin,
      'userId': userId,
    };
  }

  @override
  String toString() => 'CheckLoginCodeRequestDto(pin: $pin, userId: $userId)';
}
