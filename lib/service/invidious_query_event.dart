

import 'package:equatable/equatable.dart';
import 'package:otube/service/invidious_query_type.dart';

abstract class InvidiousQueryEvent extends Equatable {
  const InvidiousQueryEvent();

  @override
  List<Object> get props => [];
}

class Refresh extends InvidiousQueryEvent {
  final InvidiousQueryType type;

  Refresh({this.type});
  @override
  List<Object> get props => [type];
  @override
  String toString() => 'Refresh { type: $type }';
}
class VideoQuery extends InvidiousQueryEvent {
  final String videoId;

  VideoQuery({this.videoId});

  @override
  List<Object> get props => [videoId];
  @override
  String toString() => 'VideoQuery { videoId: $videoId }';
}