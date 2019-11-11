import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otube/bloc/invidious_video_bloc.dart';
import 'package:otube/model/complete_video.dart';
import 'package:otube/model/video.dart';
import 'package:otube/service/invidious_video_event.dart';
import 'package:otube/state/invidious_query_state.dart';
import 'package:video_player/video_player.dart';

class InvidiousVideoHandler extends StatefulWidget {
  final Video video;

  const InvidiousVideoHandler({Key key, this.video}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InvidiousVideoHandlerState(video);
}

class _InvidiousVideoHandlerState extends State<InvidiousVideoHandler> {
  final Video video;
  InvidiousVideoBloc _videoBloc;

  _InvidiousVideoHandlerState(this.video);

  @override
  void initState() {
    super.initState();
    _videoBloc = BlocProvider.of(context);
    _videoBloc.add(VideoQuery(videoId: video.videoId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvidiousVideoBloc, InvidiousQueryState>(
      bloc: BlocProvider.of(context),
      builder: (context, state) {
        if (state is InvidiousQueryLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is InvidiousQueryError) {
          return Text("error");
        }
        if (state is InvidiousQuerySuccess) {
          return InvidiousVideoPlayer(video: state.result);
        }

        return Text("Nothing here ...");
      },
    );
  }
}

class InvidiousVideoPlayer extends StatefulWidget {
  final CompleteVideo video;

  const InvidiousVideoPlayer({Key key, @required this.video}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InvidiousVideoPlayer(video);
}

class _InvidiousVideoPlayer extends State<InvidiousVideoPlayer> {
  final CompleteVideo video;
  VideoPlayerController _controller;
  ChewieController _chewie;

  _InvidiousVideoPlayer(this.video);

  @override
  void initState() {
    _controller = VideoPlayerController.network(video.formatStreams[0].url);
    _chewie = ChewieController(
        videoPlayerController: _controller,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: false,
        showControls: true);
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewie,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewie.dispose();
  }
}