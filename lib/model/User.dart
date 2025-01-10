
class User {
  String? name;
  String? email;
  String? username;
  String? nationalId;
  String? healthInsuranceNumber;
  int? age;
  String? gender;
  String? phoneNumber;
  String? address;
  String? identityImage;
  String? role;
  bool? isVerified;
  String? specialty;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? token;

  User({
    this.username,
    this.name,
    this.address,
    this.age,
    this.email,
    this.gender,
    this.healthInsuranceNumber,
    this.identityImage,
    this.isVerified,
    this.nationalId,
    this.phoneNumber,
    this.role,
    this.specialty,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'is_verified': isVerified,
      'identity_image': identityImage,
      'address': address,
      'phone_number': phoneNumber,
      'gender': gender,
      'age': age,
      'health_insurance_number': healthInsuranceNumber,
      'national_id': nationalId,
      'username': username,
      'role': role,
      'specialty': specialty,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
      'access_token': token,
    };
  }

  factory User.fromJson(Map<String, dynamic> json,{String? token}) {
    return User(
      token: token??json['access_token'],
      name: json['name'],
      email: json['email'],
      isVerified: json['is_verified'] == 0?false:true,
      identityImage: json['identity_image'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      gender: json['gender'],
      age: json['age'],
      healthInsuranceNumber: json['health_insurance_number'],
      nationalId: json['national_id'],
      username: json['username'],
      role: json['role'],
      specialty: json['specialty'],
      updatedAt: json['updated_at'],
      createdAt: json['created_at'],
      id: json['id'],
    );
  }
  @override
  String toString() {
    return 'User(name: $name, email: $email, specialty: $specialty, phoneNumber: $phoneNumber, address: $address, role: $role, isVerified: $isVerified, token: $token)';
  }
}
