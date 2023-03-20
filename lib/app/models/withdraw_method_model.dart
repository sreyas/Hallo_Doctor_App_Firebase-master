class WithdrawMethod {
  WithdrawMethod(
      {this.withdrawMethodId, this.name, this.email, this.method, this.userId});
  String? withdrawMethodId;
  String? name;
  String? email;
  String? method;
  String? userId;

  static const String _withdrawMethodId = 'withdrawMethodId';
  static const String _name = 'name';
  static const String _email = 'email';
  static const String _method = 'method';
  static const String _userId = 'userId';

  factory WithdrawMethod.fromJson(Map<String, dynamic> json) {
    return WithdrawMethod(
        withdrawMethodId: json[_withdrawMethodId],
        name: json[_name],
        email: json[_email],
        method: json[_method],
        userId: json[_userId]);
  }
  Map<String, dynamic> toMap(WithdrawMethod withdrawMethod) {
    return {
      _withdrawMethodId: withdrawMethod.withdrawMethodId,
      _name: withdrawMethod.name,
      _email: withdrawMethod.email,
      _method: withdrawMethod.method,
      _userId: withdrawMethod.userId
    };
  }
}
