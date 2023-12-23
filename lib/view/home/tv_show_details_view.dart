import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:ott_photo_play/common/color_extension.dart';
import 'package:ott_photo_play/common_widget/round_button.dart';
import 'package:ott_photo_play/view/download/download_view.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TvShowDetailsView extends StatefulWidget {
  const TvShowDetailsView({Key? key}) : super(key: key);

  @override
  State<TvShowDetailsView> createState() => _TvShowDetailsViewState();
}

class _TvShowDetailsViewState extends State<TvShowDetailsView> {
  List epArr = [
    {"name": "Tập 1 ", "image": "assets/img/tet2.png", "duration": "54 min"},
    {"name": "Tập 2", "image": "assets/img/tet1.png", "duration": "55 min"},
    {"name": "Tập 3", "image": "assets/img/tet5.png", "duration": "50 min"},
    {"name": "Tập 4", "image": "assets/img/tet2.png", "duration": "54 min"},
    {"name": "Tập 5", "image": "assets/img/tet5.png", "duration": "54 min"},
    {"name": "Tập 6", "image": "assets/img/tet1.png", "duration": "55 min"},
    {"name": "Tập 7", "image": "assets/img/tet2.png", "duration": "50 min"},
    {"name": "Tập 8", "image": "assets/img/tet5.png", "duration": "54 min"},
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
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.bg,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      width: media.width,
                      height: media.width * 0.8,
                      child: ClipRect(
                        child: Image.asset(
                          "assets/img/tet1.png",
                          width: media.width,
                          height: media.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: media.width,
                      height: media.width * 0.8,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                TColor.bgDark,
                                TColor.bgDark.withOpacity(0),
                                TColor.bg.withOpacity(0),
                                TColor.bg
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                    ),
                    Container(
                      width: media.width,
                      height: media.width * 0.8,
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VideoPlayerView()),
                          );
                        },
                        child: Image.asset("assets/img/play-button.png",
                            width: 55, height: 55),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tết Ở Làng Địa Ngục ",
                            style: TextStyle(
                                color: TColor.bgText,
                                fontSize: 19,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Drama",
                                style: TextStyle(
                                    color: TColor.bgText,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " | ",
                                style: TextStyle(
                                    color: TColor.bgText,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Biographical",
                                style: TextStyle(
                                    color: TColor.bgText,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " | ",
                                style: TextStyle(
                                    color: TColor.bgText,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Crime Film",
                                style: TextStyle(
                                    color: TColor.bgText,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                " | ",
                                style: TextStyle(
                                    color: TColor.bgText,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "Crime Fiction",
                                style: TextStyle(
                                    color: TColor.bgText,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Text(
                  "9.0",
                  style: TextStyle(
                    color: TColor.bgText,
                    fontSize: 33,
                  ),
                ),
                IgnorePointer(
                  ignoring: true,
                  child: RatingBar(
                    initialRating: 4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 18,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    ratingWidget: RatingWidget(
                      full: Image.asset("assets/img/star_fill.png"),
                      half: Image.asset("assets/img/star.png"),
                      empty: Image.asset("assets/img/star.png"),
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    "Tết Ở Làng Địa Ngục - Hellbound Village (2023) kể về một ngôi làng nằm sâu trong rừng heo hút ở trên núi cao, nơi mà sương mù quanh năm che phủ được đặt tên là Làng Địa Ngục, những câu chuyện kỳ lạ xảy đến với người dân làng những ngày Tết năm đó...",
                    style: TextStyle(
                      color: TColor.text,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 150,
                  child: RoundButton(
                    title: "WATCH NOW",
                    height: 40,
                    onPressed: () {
                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) =>
                                   VideoPlayerView()));
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Episodes",
                        style: TextStyle(
                            color: TColor.text,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: epArr.length,
                  itemBuilder: (context, index) {
                    var cObj = epArr[index] as Map? ?? {};
                    var image = cObj["image"].toString();

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VideoPlayerView()),
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8),
                            color: TColor.castBG,
                            width: media.width * 0.35,
                            height: media.width * 0.25,
                            child: image != ""
                                ? ClipRect(
                              child: Image.asset(
                                image,
                                width: media.width * 0.35,
                                height: media.width * 0.25,
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
                                    cObj["name"].toString(),
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: TColor.text,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    cObj["duration"].toString(),
                                    style: TextStyle(
                                        color: TColor.subtext, fontSize: 13),
                                  ),
                                ),
                                TextButton.icon(
                                    onPressed: () async {
                                      await saveDownloadInfo(
                                        cObj["name"].toString(),
                                        image,
                                        'https://drive.google.com/uc?export=download&id=1Vpdjx_K_a3Qjdw9KLPQhStEqU5zjv1u0',
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => DownloadView()),
                                      );
                                    },
                                    icon: Image.asset(
                                      "assets/img/tab_download.png",
                                      width: 13,
                                      height: 13,
                                      color: TColor.primary2,
                                    ),
                                    label: Text(
                                      "Download",
                                      style: TextStyle(
                                          color: TColor.primary2,
                                          fontSize: 12, fontWeight: FontWeight.w500),
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leadingWidth: 100,
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "assets/img/back_btn.png",
                            width: 13,
                            height: 13,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            "BACK",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColor.primary1,
        onPressed: () {
          TColor.tModeDark = !TColor.tModeDark;
          FBroadcast.instance().broadcast("change_mode");
          if (mounted) {
            setState(() {});
          }
        },
        child: Icon(
          TColor.tModeDark ? Icons.light_mode : Icons.dark_mode,
          color: TColor.text,
        ),
      ),
    );
  }

  Future<void> saveDownloadInfo(String episodeName, String imageUrl, String videoUrl) async {
    CollectionReference downloads = FirebaseFirestore.instance.collection('downloads');
    await downloads.add({
      'episodeName': episodeName,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}


class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({Key? key}) : super(key: key);

  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://drive.google.com/uc?export=download&id=1Vpdjx_K_a3Qjdw9KLPQhStEqU5zjv1u0'

    );
    _initializeVideoPlayerFuture = initializeVideoPlayer();
  }

  Future<void> initializeVideoPlayer() async {
    await _controller.initialize();
    if (mounted) {
      setState(() {}); // Đảm bảo widget được xây dựng lại sau khi khởi tạo
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
