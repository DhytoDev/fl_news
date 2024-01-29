sealed class AuthenticationEvent {}

class GetAuthenticationStatusEvent extends AuthenticationEvent {}

class SignOutEvent extends AuthenticationEvent {}
