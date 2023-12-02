import 'package:pigemshubshop/core/domain/entities/transaction/transaction.dart';
import 'package:pigemshubshop/core/domain/repositories/transaction_repository.dart';

class AcceptTransaction {
  final TransactionRepository _repository;

  AcceptTransaction(this._repository);

  Future<void> execute({required Transaction data}) async {
    return await _repository.acceptTransaction(data: data);
  }
}
