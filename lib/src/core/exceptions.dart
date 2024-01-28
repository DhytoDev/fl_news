import 'package:equatable/equatable.dart';

final class NetworkException extends Equatable implements Exception {
  final int status;
  final String? message;

  const NetworkException({
    required this.status,
    this.message,
  });

  @override
  List<Object?> get props => [status, message];
}
