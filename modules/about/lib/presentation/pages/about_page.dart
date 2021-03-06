import 'package:core/core.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Center(
                    child: Image.asset('assets/circle-g.png'),
                  ),
                  color: kPrussianBlue,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  color: kMikadoYellow,
                ),
              ),
            ],
          ),
          SafeArea(
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_rounded),
              tooltip: 'Back',
            ),
          )
        ],
      ),
    );
  }
}
