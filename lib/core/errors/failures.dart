abstract class Failure {
  final String errmessage;

  Failure({required this.errmessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errmessage});
}
