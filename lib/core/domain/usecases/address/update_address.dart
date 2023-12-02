import 'package:pigemshubshop/core/domain/entities/address/address.dart';
import 'package:pigemshubshop/core/domain/repositories/address_repository.dart';

class UpdateAddress {
  final AddressRepository _repository;

  UpdateAddress(this._repository);

  Future<void> execute({required String accountId, required Address data}) async {
    return await _repository.updateAddress(accountId: accountId, data: data);
  }
}
