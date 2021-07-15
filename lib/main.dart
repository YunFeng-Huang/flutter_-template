import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '打开蓝牙'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String? title;

  MyHomePage({Key? key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _message = '检查蓝牙状态中....';

  ///////////Flutter 调用原生 Start//////////////
  static const MethodChannel methodChannel = MethodChannel('samples.flutter.io/bluetooth');

  Future<void> _openBlueTooth() async {
    String message;
    message = await methodChannel.invokeMethod('openBuleTooth');
    setState(() {
      _message = message;
    });
  }

  Future<void> _getBlueTooth() async {
    String message;
    message = await methodChannel.invokeMethod('getBuleTooth');
    setState(() {
      _message = message;
    });
  }

  Future<void> _openXiTongApi() async {
    String message;
    message = await methodChannel.invokeMethod('openXiTongApi');
    setState(() {
      _message = message;
    });
  }

  //////// Flutter 调用原生  End  ////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('蓝牙状态:'),
                    Text(
                      _message,
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Text('打开蓝牙'),
                          onPressed: _openBlueTooth,
                        ),
                        RaisedButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Text('检测蓝牙状态'),
                          onPressed: _getBlueTooth,
                        ),
                        ElevatedButton(
                          // style: ButtonStyle(backgroundColor:Colors.red),
                          child: Text('唤起系统api'),
                          onPressed: _openXiTongApi,
                        ),
                        PdfPreview(
                          build: (format) => _generatePdf(format, 'title'),
                        )
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.SizedBox(
                width: double.infinity,
                child: pw.FittedBox(
                  child: pw.Text(title, style: pw.TextStyle(font: font)),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Flexible(child: pw.FlutterLogo())
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
