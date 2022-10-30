class LocalModel {
  String name;
  String email;
  int age;
  bool isActive;
  String? avatar;

  LocalModel(
      {required this.name,
      required this.email,
      required this.age,
      this.isActive = true,
      this.avatar});
}
