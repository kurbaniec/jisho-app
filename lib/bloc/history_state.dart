
import 'package:equatable/equatable.dart';

import '../model/history.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final Map<String, List<WebHistory>> histories;

  const HistoryLoaded({required this.histories});

  @override
  List<Object> get props => [histories];
}