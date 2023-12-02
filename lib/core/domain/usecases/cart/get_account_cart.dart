import 'package:pigemshubshop/core/domain/entities/cart/cart.dart';
import 'package:pigemshubshop/core/domain/repositories/cart_repository.dart';

class GetAccountCart {
  final CartRepository _repository;

  GetAccountCart(this._repository);

  Future<List<Cart>> execute({required String accountId}) async {
    return _repository.getAccountCart(accountId: accountId);
  }
}
