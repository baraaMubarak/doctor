class ApiConfig{
  static const domain = 'http://127.0.0.1:8000/api/';
  static const String login = '${domain}login';
  static const String registerPatient = '${domain}register/patient';
  static const String registerDoctor = '${domain}register/doctor';
  static const String getDoctors = '${domain}doctors';
  static const String getPending = '${domain}admin/pending-users';
  static const String getUsers = '${domain}admin/all-users';
  static const String deleteUser = '${domain}admin/delete-user/';
}

