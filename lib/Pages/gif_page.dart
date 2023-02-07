import 'package:flutter/Material.dart';

class GifPage extends StatelessWidget {
  final Map _gifData;

  const GifPage(this._gifData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          _gifData["title"],
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Image.network(
          _gifData["images"]["downsized"]["url"],
        ),
      ),
    );
  }
}
