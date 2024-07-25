// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PinchPage extends StatefulWidget {
  const PinchPage({super.key});

  @override
  State<PinchPage> createState() => _PinchPageState();
}

enum DocShown { sample, tutorial, hello, password }

class _PinchPageState extends State<PinchPage> {
  static const int _initialPage = 1;
  late PdfControllerPinch _pdfControllerPinch;

  @override
  void initState() {
    var uri = Uri.dataFromString(
        html.window.location.href); //converts string to a uri
    Map<String, String> params =
        uri.queryParameters; // query parameters automatically populated
    String? param1 =
        params['pdf']; // return value of parameter "param1" from uri

    _pdfControllerPinch = PdfControllerPinch(
      // document: PdfDocument.openAsset('assets/hello.pdf'),
      document: PdfDocument.openAsset(
          param1 == null ? "pdf/spring.pdf" : "pdf/$param1.pdf"),
      // PdfDocument.openData(
      //   InternetFile.get(
      //     (param1 == null) ? 'https://test.yeonts.com/meeting.pdf' : param1,
      //   ),
      // ),
      initialPage: _initialPage,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pdfControllerPinch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Image.asset("assets/images/logo_b.png"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.navigate_before),
            onPressed: () {
              _pdfControllerPinch.previousPage(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 100),
              );
            },
          ),
          PdfPageNumber(
            controller: _pdfControllerPinch,
            builder: (_, loadingState, page, pagesCount) => Container(
              alignment: Alignment.center,
              child: Text(
                '$page/${pagesCount ?? 0}',
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            onPressed: () {
              _pdfControllerPinch.nextPage(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 100),
              );
            },
          ),
        ],
      ),
      body: PdfViewPinch(
        builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
          options: const DefaultBuilderOptions(),
          documentLoaderBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          pageLoaderBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          errorBuilder: (_, error) => Center(child: Text(error.toString())),
        ),
        controller: _pdfControllerPinch,
      ),
    );
  }
}
