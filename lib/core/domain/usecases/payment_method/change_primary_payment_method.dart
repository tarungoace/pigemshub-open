import 'package:pigemshubshop/core/domain/entities/payment_method/payment_method.dart';
import 'package:pigemshubshop/core/domain/repositories/payment_method_repository.dart';

class ChangePrimaryPaymentMethod {
  final PaymentMethodRepository _repository;

  ChangePrimaryPaymentMethod(this._repository);

  Future<void> execute({required String accountId, required PaymentMethod paymentMethod}) async {
    return await _repository.changePrimaryPaymentMethod(accountId: accountId, paymentMethod: paymentMethod);
  }
}
