import 'package:flutter/material.dart';

class LoadingNext extends StatefulWidget {
  @override
  _LoadingNext createState() => _LoadingNext();
}

class _LoadingNext extends State<LoadingNext> {
  int _count = 50;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Loading next data"),
        ),
        body: _createBody(context),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    List<int> _data = [for (var i = 0; i < 200; i++) i];
    Future<List<int>> _fetch(int count) {
      return Future.delayed(
        Duration(seconds: 2),
        () => _data.where((element) => element < count).toList(),
      );
    }

    final controller = ScrollController();

    return FutureBuilder(
      future: _fetch(_count),
      builder: (BuildContext context, AsyncSnapshot<List<int>?> snapshot) {
        final data = snapshot.data;
        if (data == null) {
          return Center(child: CircularProgressIndicator());
        }

        controller.addListener(() {
          final position =
              controller.offset / controller.position.maxScrollExtent;

          if (position >= 0.8) {
            if (data.length == _count < _data.length) {
              setState(() {
                _count += 50;
              });
            }
          }
        });

        return ListView.builder(
          controller: controller,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("Item number - ${data[index]}"));
          },
        );
      },
    );
  }
}
