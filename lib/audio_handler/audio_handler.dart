import 'package:audio_service/audio_service.dart';

class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  @override
  Future<void> play() async {}

  @override
  Future<void> pause() async {}

  @override
  Future<void> stop() async {}

  @override
  Future<void> seek(Duration position) async {}

  @override
  Future<void> skipToQueueItem(int i) async {}
}
