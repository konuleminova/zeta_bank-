class LoginResponse {
  final int userId;
  final String accessToken;
  final String smsOtpCode;
  final String smsOtpId;


  LoginResponse({this.userId, this.accessToken, this.smsOtpCode, this.smsOtpId});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      userId: json['userId'],
      accessToken: json['accessToken'],
      smsOtpCode: json['smsOtpCode'],
      smsOtpId: json['smsOtpId'],
    );
  }

  @override
  String toString() {
    return 'LoginResponse{userId: $userId, accessToken: $accessToken, smsOtpCode: $smsOtpCode, smsOtpId: $smsOtpId}';
  }

}
