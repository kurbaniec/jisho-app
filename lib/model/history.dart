
import 'package:equatable/equatable.dart';

class WebHistory extends Equatable {
  final String url;
  final DateTime visited;

  const WebHistory({
    required this.url,
    required this.visited
  });

  @override
  List<Object?> get props => [url, visited];
}