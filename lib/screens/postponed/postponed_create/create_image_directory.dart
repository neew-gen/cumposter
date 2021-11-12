import 'dart:async';
import 'dart:io';

import 'package:cumposter/controllers/postponed/create/images/images_path.dart';
import 'package:cumposter/widgets/stateful_wrapper.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostponedCreateImageDirectory extends StatelessWidget {
  final FileManagerController controller = FileManagerController();
  _setCurrentPath() {
    var path = PostponedCreateImagesPathController.to.imagesPath.value;
    controller.setCurrentPath = path;
  }

  _clickGoToParentDirectory() async {
    var isRootDirectory = await controller.isRootDirectory();
    if (!isRootDirectory) {
      return controller.goToParentDirectory();
    } else {
      return null;
    }
  }

  _clickChooseFolder() {
    var currentDir = controller.getCurrentDirectory;
    var path = currentDir.path;
    PostponedCreateImagesPathController.to.updateImagesPath(path);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        Timer(Duration(milliseconds: 100), () => _setCurrentPath());
        // _setCurrentPath;
      },
      child: ControlBackButton(
        controller: controller,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(90), // Set this height
            child: Container(
              padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Вернуться',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _clickChooseFolder,
                        child: Text(
                          'Выбрать папку',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: _clickGoToParentDirectory,
                        child: Text(
                          'На уровень вверх',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: FileManager(
            controller: controller,
            builder: (context, snapshot) {
              final List<FileSystemEntity> entities = snapshot;
              return ListView.builder(
                itemCount: entities.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: FileManager.isFile(entities[index])
                          ? Icon(Icons.feed_outlined)
                          : Icon(Icons.folder),
                      title: Text(FileManager.basename(entities[index])),
                      onTap: () {
                        if (FileManager.isDirectory(entities[index])) {
                          controller
                              .openDirectory(entities[index]); // open directory
                        } else {
                          // Perform file-related tasks.
                        }
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
