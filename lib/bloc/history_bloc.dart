import 'package:bloc/bloc.dart';
import 'package:jisho_app/bloc/history_event.dart';
import 'package:jisho_app/bloc/history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  // TODO add repository
  HistoryBloc() : super(HistoryInitial()) {
    on<LoadHistories>((event, emit) {
      // TODO call load repo
      emit(const HistoryLoaded(histories: []));
    });
    on<AddHistory>((event, emit) {
      if (state is HistoryLoaded) {
        final state = this.state as HistoryLoaded;
        emit(HistoryLoaded(
            histories: List.from(state.histories)..add(event.history)));
      }
    });
  }
}
