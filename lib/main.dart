import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Image imageTest = Image.asset('assets/images/images.png');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                shareText();
              },
              child: const Text('Share Text'),
            ),
            ElevatedButton(
              onPressed: () {
                _shareImageFromAssets();
              },
              child: const Text('Share Img'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _shareImageFromAssets() async {
  try {
    // Carrega a imagem dos assets
    final byteData = await rootBundle.load('assets/images/images.png');

    // Salva a imagem no diretório temporário
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/images.png';
    final file = File(filePath);
    await file.writeAsBytes(byteData.buffer.asUint8List());

    // Compartilha a imagem
    final xFile = XFile(filePath);
    await Share.shareXFiles([xFile], text: 'Confira esta imagem!');
  } catch (e) {
    print("Erro ao compartilhar a imagem: $e");
  }
}

void shareText() {
  const String shareText = 'text test';
  Share.share(shareText);
}
