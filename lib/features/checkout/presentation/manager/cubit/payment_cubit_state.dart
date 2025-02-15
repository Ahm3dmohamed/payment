part of 'payment_cubit.dart';

@immutable
sealed class PaymentCubitState {}

final class PaymentInitial extends PaymentCubitState {}

final class PaymentLoading extends PaymentCubitState {}

final class PaymentSuccess extends PaymentCubitState {}

final class PaymentFailure extends PaymentCubitState {
  final String errMessage;
  PaymentFailure(this.errMessage);
}
