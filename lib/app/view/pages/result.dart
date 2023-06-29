import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:omr_scanner/app/model/result.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.result});

  final Result result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(result.name),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: result.answers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(result.answers[index]),
            leading: const Icon(Icons.check),
          );
        },
      ),
    );
  }
}