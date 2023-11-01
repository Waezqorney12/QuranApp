import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class Song {
  AudioPlayer player = AudioPlayer();

  Future<void> playAudio(String? audioUrl,) async {
    if (audioUrl != null) {
      try {
        await player.setUrl(audioUrl);
        await player.play();
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: "Error",
          middleText: "Error tidak diketahui ${e.message}",
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: "Error",
          middleText: "Error tidak diketahui ${e.message}",
        );
      } catch (e) {
        Get.defaultDialog(
          title: "Error",
          middleText: "Error tidak diketahui $e",
        );
      }

      // Catching errors during playback (e.g. lost network connection)
      player.playbackEventStream.listen((event) {},
          onError: (Object e, StackTrace st) {
        if (e is PlayerException) {
          Get.defaultDialog(
            title: "Error",
            middleText: "Error tidak diketahui ${e.message}",
          );
        } else {
          Get.defaultDialog(
            title: "Error",
            middleText: "Error tidak diketahui $e",
          );
        }
      });
    }
  }

    Future<void> stopAudio(String? audioUrl, ) async {
    if (audioUrl != null) {
      try {
        await player.setUrl(audioUrl);
        await player.stop();
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: "Error",
          middleText: "Error tidak diketahui ${e.message}",
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: "Error",
          middleText: "Error tidak diketahui ${e.message}",
        );
      } catch (e) {
        Get.defaultDialog(
          title: "Error",
          middleText: "Error tidak diketahui $e",
        );
      }

      // Catching errors during playback (e.g. lost network connection)
      player.playbackEventStream.listen((event) {},
          onError: (Object e, StackTrace st) {
        if (e is PlayerException) {
          Get.defaultDialog(
            title: "Error",
            middleText: "Error tidak diketahui ${e.message}",
          );
        } else {
          Get.defaultDialog(
            title: "Error",
            middleText: "Error tidak diketahui $e",
          );
        }
      });
    }
  }
}
