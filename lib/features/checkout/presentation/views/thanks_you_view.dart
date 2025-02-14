import 'package:flutter/material.dart';
import 'package:payment/core/widgets/build_appbar.dart';
import 'package:payment/features/checkout/presentation/views/thanksyou_view_body.dart';

class ThanksYouView extends StatelessWidget {
  const ThanksYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows body to extend behind AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make AppBar transparent
        elevation: 0, // Remove shadow
        title: const Text(""),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const ThanksyouViewBody(),
    );
  }
}
