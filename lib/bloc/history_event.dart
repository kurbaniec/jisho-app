
import 'package:equatable/equatable.dart';
import 'package:jisho_app/model/history.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadHistories extends HistoryEvent {}

class AddHistory extends HistoryEvent {
  final WebHistory history;

  const AddHistory(this.history);

  @override
  List<Object> get props => [history];
}