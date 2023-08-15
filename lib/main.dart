import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statement_app/provider/statement_provider.dart';


import 'home.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => TransactionProvider(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transaction Statement Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TransactionsScreen(),
    );
  }
}
