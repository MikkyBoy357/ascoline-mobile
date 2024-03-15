class TokenModel {
  final String? token;
  final num? expiresIn;
  final num? createdAt;

  TokenModel({
    this.token,
    this.expiresIn,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'expiresIn': expiresIn,
      'createdAt': createdAt,
    };
  }

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      token: json["token"],
      expiresIn: json["expiresIn"] ?? 18000000,
      createdAt: json["createdAt"] ?? DateTime.now().millisecondsSinceEpoch,
    );
  }

  bool get hasExpired {
    final expireTime = createdAt! + expiresIn!;
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    return expireTime < currentTime;
  }
}
