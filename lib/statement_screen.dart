import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statement_app/provider/statement_provider.dart';



class GenerateStatementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Statement'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _generateStatement(context),
          child: const Text('Generate Statement'),
        ),
      ),
    );
  }

  void _generateStatement(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context, listen: false);
    transactionProvider.loadDummyData();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:const Text('Statement Generated'),
        content: const Text('Transaction statement generated successfully.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
