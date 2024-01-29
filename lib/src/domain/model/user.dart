import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userName;
  final String firstName;
  final String lastName;
  final String email;

  const User({
    this.userName = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
  });

  @override
  List<Object?> get props => [userName, firstName, lastName, email];

  static List<User> users = [
    const User(
      userName: 'magnus',
      firstName: 'Magnus',
      lastName: 'Digital',
      email: 'magnusdigital@gmail.com',
    ),
    const User(
      userName: 'dhytodev',
      firstName: 'Fordyta',
      lastName: 'Abubakar',
      email: 'dhytodev@gmail.com',
    ),
  ];
}
