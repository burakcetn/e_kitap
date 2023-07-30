import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/sub_title.dart';
import '../../data/models/books/word_model.dart';
import 'index.dart';
import 'package:audioplayers/audioplayers.dart';

class BooklistenController extends GetxController {
  RxList<InlineSpan> words = RxList.empty();

  BooklistenController();
  AudioPlayer audioPlayer = AudioPlayer();
  late StreamSubscription<Duration> positionSub;
  final state = BooklistenState();
  BookManager? currentBook;
  void setupAudioPlayer() {
    audioPlayer.onPlayerComplete.listen((event) {
      positionSub.cancel();
      isPlaying.value = true;
      isPlaying.update((val) {});
    });
    audioPlayer.onPlayerStateChanged.listen((event) async {
      isPlaying.value = event == PlayerState.playing;
      audioPlayer
          .getDuration()
          .then((value) => maxPosition.value = value?.inMilliseconds ?? 1);

      isPlaying.update((val) {});
    });
    positionSub = audioPlayer.onPositionChanged.listen(onPositionChange);
  }

  RxInt maxPosition = (0).obs;
  RxDouble currentPosition = (0.0).obs;
  Subtitle? current;
  int oldSecond = 0;
  int index = 0;
  int oldIndex = 0;
  Future<void> onPositionChange(Duration duration) async {
    var seconds = duration.inMilliseconds;
    currentPosition.value = seconds.toDouble();
    currentPosition.update((val) {});
    currentBook?.wordWrap(seconds, audioPlayer);
    //
    //
    // wordWrap(currentPositionx);
  }

  RxBool isPlaying = false.obs;

  /// 在 widget 内存中分配后立即调用。
  @override
  void onInit() {
    super.onInit();
    setupAudioPlayer();
  }

  /// 在 onInit() 之后调用 1 帧。这是进入的理想场所
  @override
  void onReady() {
    super.onReady();
  }

  /// 在 [onDelete] 方法之前调用。
  @override
  void onClose() {
    super.onClose();
  }

  /// dispose 释放内存
  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void playOrPaue() {
    if (isPlaying.value) {
      audioPlayer.pause();
    } else {
      play(currentBook!, Get.context);
    }
  }

  void stop() {
    audioPlayer.stop();
  }

  Future<void> play(BookManager bookName, context) async {
    currentBook = bookName;
    audioPlayer.seek(0.milliseconds);
    audioPlayer.setSource(AssetSource(bookName.book.audioPath));
  }

  void setBook(BookManager book) {
    currentBook = book;
    setupAudioPlayer();
  }
}
