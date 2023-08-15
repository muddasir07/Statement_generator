import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statement_app/provider/statement_provider.dart';
import 'package:statement_app/statement_screen.dart';
import 'package:statement_app/transaction.dart';
import 'package:statement_app/view_statement_screen.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class TransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Transactions'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _viewStatement(context),
              child: const Text('View Statement'),
            ),
            ElevatedButton(
              onPressed: () => _generateStatement(context),
              child: const Text('Generate Statement'),
            ),
            ElevatedButton(
              onPressed: () => _downloadStatement(context),
              child: const Text('Download PDF'),
            ),
          ],
        ),
      ),
    );
  }

  void _viewStatement(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ViewStatementScreen(),
      ),
    );
  }

  void _generateStatement(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GenerateStatementScreen(),
      ),
    );
  }

  void _downloadStatement(BuildContext context) async {
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);
    final transactions = transactionProvider.transactions;
    if (transactions.isNotEmpty) {
      final pdf = await generatePDF(transactions);
      await savePDFToStorage(pdf);
     showDialog( 
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Download Complete'),
        content: const Text('Transaction statement downloaded successfully.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Statement Not Generated'),
          content: const
              Text('Please generate the statement first before downloading.'),
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

  Future<pw.Document> generatePDF(List<Transaction> transactions) async {
  final pdf = pw.Document();

  final ttfRegular = await rootBundle.load('assets/fonts/NotoSans-Regular.ttf');
  final ttfBold = await rootBundle.load('assets/fonts/NotoSans-Bold.ttf');

  final pw.Font regularFont = pw.Font.ttf(ttfRegular);
  final pw.Font boldFont = pw.Font.ttf(ttfBold);

  final pw.TextStyle textStyle = pw.TextStyle(
    font: regularFont,
    fontSize: 14,
  );

  final pw.TextStyle boldTextStyle = pw.TextStyle(
    font: boldFont,
    fontSize: 14,
    fontWeight: pw.FontWeight.bold,
  );

  pdf.addPage(
    pw.MultiPage(
      build: (pw.Context context) => [
        pw.Header(text: 'Transaction Statement', level: 0),
        pw.Divider(),
        for (var transaction in transactions)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('User Name: ${transaction.userName}', style: textStyle),
              pw.Text('CNIC: ${transaction.cnic}', style: textStyle),
              pw.Text('Date of Issue: ${transaction.dateOfIssue}', style: textStyle),
              pw.Text('Account Number: ${transaction.accountNumber}', style: textStyle),
              pw.Text('Transaction Details: ${transaction.transactionDetails}', style: boldTextStyle),
              pw.Divider(),
            ],
          ),
      ],
    ),
  );

  return pdf;
}


  Future<void> savePDFToStorage(pw.Document pdf) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/transaction_statement.pdf');
  await file.writeAsBytes(await pdf.save());
  }
}
