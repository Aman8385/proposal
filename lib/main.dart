import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mine/proposal_binding.dart';
import 'package:mine/proposal_page.dart';

void main() {
  runApp(const ProposalApp());
}

class ProposalApp extends StatelessWidget {
  const ProposalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ProposalBinding(),
      home: const ProposalPage(),
    );
  }
}
