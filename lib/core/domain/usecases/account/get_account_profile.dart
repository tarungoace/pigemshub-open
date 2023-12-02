import 'package:pigemshubshop/core/domain/entities/account/account.dart';
import 'package:pigemshubshop/core/domain/repositories/account_repository.dart';

class GetAccountProfile {
  final AccountRepository _repository;

  GetAccountProfile(this._repository);

  Future<Account?> execute({required String accountId}) async {
    return _repository.getAccountProfile(accountId: accountId);
  }
}
