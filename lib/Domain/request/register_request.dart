class RegisterRequest {
  String id;
  String password;
  int role;
  String name;
  String? email;
  String? tel;

  RegisterRequest(this.id, this.password, this.role, this.name, {this.email, this.tel});
}
