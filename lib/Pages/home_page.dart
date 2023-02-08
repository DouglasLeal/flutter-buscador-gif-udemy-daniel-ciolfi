import 'package:buscador_gif/Pages/gif_page.dart';
import 'package:buscador_gif/Services/GifService.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _search = null;

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
      margin: EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          onSubmitted: (text) {
            GifService.offSet = 0;
            setState(() {
              _search = text;
            });
          },
          decoration: const InputDecoration(
            labelText: "Procurar...",
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            border: OutlineInputBorder(),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        const Divider(),
        Expanded(
          child: FutureBuilder(
            future: GifService.get(search: _search),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      strokeWidth: 5,
                    ),
                  );
                case ConnectionState.active:
                case ConnectionState.done:
                  return _gifGrid(context, snapshot);
              }
            },
          ),
        ),
      ]),
    );
  }

  _gifGrid(context, snapshot) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: snapshot.data["data"].length + 1,
        itemBuilder: (context, index) {
          if (index < snapshot.data["data"].length) {
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => GifPage(snapshot.data["data"][index])));
              },
              onLongPress: (){ Share.share(snapshot.data["data"][index]["images"]["downsized"]["url"]); },
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: snapshot.data["data"][index]["images"]["downsized"]["url"],
                height: 300,
                fit: BoxFit.cover,
              ),
            );
          } else {
            return GestureDetector(
              onTap: (){
                GifService.offSet += 19;

                setState(() {
                  GifService.get(search: _search);
                });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 70,
                  ),
                  Text(
                    "Carregar mais...",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
            );
          }
        });
  }
}
