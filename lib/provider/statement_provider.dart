import 'package:flutter/material.dart';
import 'package:statement_app/transaction.dart';


class TransactionProvider extends ChangeNotifier {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  void loadDummyData() {
    _transactions = [
      Transaction(
        userName: 'MR. Osama',
        cnic: '1234567890',
        dateOfIssue: '2023-08-04',
        accountNumber: '1234567890',
        transactionDetails: 'Payment for services',
      ),
      Transaction(
        userName: 'Mr. Ibtessam',
        cnic: '98765-43210',
        dateOfIssue: '2023-08-03',
        accountNumber: '0987654321',
        transactionDetails: 'Purchase of goods',
      ),
      Transaction(
        userName: 'Muddasir',
        cnic: '12345-67890',
        dateOfIssue: '2023-08-04',
        accountNumber: '1234567890',
        transactionDetails: 'Payment for Salary',
      ),
    ];

    notifyListeners();
  }
}
