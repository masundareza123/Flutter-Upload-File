import 'dart:io';

import 'package:file_upload/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("File Upload"),
          ),
          body: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () async {
                    await model.pickImageC();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white),
                    child: model.isPathNull() == false
                        ? const Center(
                            child: Text(
                              'Take Picture',
                            ),
                          )
                        : FittedBox(
                            child: Image.file(File(model.imagePath)),
                            // fit: BoxFit.scaleDown,
                          ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    model.uploadFile();
                  },
                  child: Text('Upload File'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
