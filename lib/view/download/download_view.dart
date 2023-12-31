import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:ott_photo_play/common/color_extension.dart';

// Assuming TColor and color_extension.dart are defined elsewhere


class DownloadView extends StatefulWidget {
  const DownloadView({Key? key});

  @override
  State<DownloadView> createState() => _DownloadViewState();
}

class _DownloadViewState extends State<DownloadView> {
  List downloadArr = [
    {
      "name": "Tập 2",
      "image": "assets/img/tet1.png",
      "size": "35MB",
      "episodes": "4",
      "is_movie": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    FBroadcast.instance().register("change_mode", (value, callback) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bg,
      appBar: AppBar(
        title: Text('Downloads'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back when the back button is pressed
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: downloadArr.length,
        itemBuilder: (context, index) {
          var dObj = downloadArr[index] as Map? ?? {};
          var media = MediaQuery.of(context).size;
          var image = dObj["image"].toString();

          return InkWell(
            onTap: () async {
              await saveDownloadInfo(
                dObj["name"].toString(),
                image,
                dObj["is_movie"] as bool? ?? false,
                dObj["size"].toString(),
                dObj["episodes"].toString(),
              );
            },
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: TColor.castBG,
                  width: media.width * 0.35,
                  height: media.width * 0.22,
                  child: image != ""
                      ? ClipRect(
                          child: Image.asset(
                            image,
                            width: media.width * 0.35,
                            height: media.width * 0.22,
                            fit: BoxFit.cover,
                          ),
                        )
                      : null,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          dObj["name"].toString(),
                          maxLines: 1,
                          style: TextStyle(
                            color: TColor.text,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          (dObj["is_movie"] as bool? ?? false)
                              ? dObj["size"].toString()
                              : "${dObj["episodes"] ?? ""} Episodes | ${dObj["size"] ?? ""}",
                          style: TextStyle(
                            color: TColor.subtext,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> saveDownloadInfo(String name, String imageUrl, bool isMovie, String size, String episodes) async {
    CollectionReference downloads = FirebaseFirestore.instance.collection('downloads');
    await downloads.add({
      'name': name,
      'imageUrl': imageUrl,
      'isMovie': isMovie,
      'size': size,
      'episodes': episodes,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
