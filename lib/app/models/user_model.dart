class UserModel {
  UserModel({this.displayName, this.photoUrl, this.userId});
  String? displayName;
  String? photoUrl;
  String? userId;

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
        displayName: jsonData['displayName'],
        photoUrl: jsonData['photoUrl'],
        userId: jsonData['userId']);
  }
}
