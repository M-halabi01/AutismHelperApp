class ContactUs {
  final String name;
  final String email;
  final String message;

  ContactUs({
    required this.name,
    required this.email,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Email': email,
      'Message': message,
    };
  }


}
