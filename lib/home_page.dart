import 'package:buscador_gif/Services/GifService.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    GifService.get().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _appbar(),
      body: _body(),
    );
  }

  _appbar() {
    return AppBar(
      title: Image.network(
          "https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif"),
      centerTitle: true,
      backgroundColor: Colors.black,
    );
  }

  _body() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(children: const [
        TextField(
          decoration: InputDecoration(
            labelText: "Procurar...",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            border: OutlineInputBorder(),
          ),
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
          ),
        ),
      ]),
    );
  }
}
