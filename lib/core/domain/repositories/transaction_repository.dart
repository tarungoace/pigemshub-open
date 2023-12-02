import 'package:pigemshubshop/core/domain/entities/review/review.dart';
import 'package:pigemshubshop/core/domain/entities/transaction/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getAccountTransaction({
    required String accountId,
  });

  Future<List<Transaction>> getAllTransaction();

  Future<Transaction?> getTransaction({required String transactionId});

  Future<void> acceptTransaction({required Transaction data});

  Future<void> changeTransactionStatus({
    required String transactionID,
    required int status,
  });

  Future<void> addReview({required String transactionId, required Review data});
}
