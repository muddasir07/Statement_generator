import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statement_app/provider/statement_provider.dart';


class ViewStatementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions = transactionProvider.transactions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Statement'),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return ListTile(
            title: Text('User Name: ${transaction.userName}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CNIC: ${transaction.cnic}'),
                Text('Date of Issue: ${transaction.dateOfIssue}'),
                Text('Account Number: ${transaction.accountNumber}'),
                Text('Transaction Details: ${transaction.transactionDetails}'),
              const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
