import 'package:bloc/bloc.dart';
import 'package:jisho_app/bloc/history_event.dart';
import 'package:jisho_app/bloc/history_state.dart';
import 'package:intl/intl.dart';
import 'package:jisho_app/model/history.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final formatter = DateFormat.yMd();

  // TODO add repository
  HistoryBloc() : super(HistoryInitial()) {
    on<LoadHistories>((event, emit) {
      // TODO call load repo
      // Group by date
      // See: https://stackoverflow.com/a/54036449
      emit(const HistoryLoaded(histories: {}));
    });
    on<AddHistory>((event, emit) {
      if (state is HistoryLoaded) {
        final state = this.state as HistoryLoaded;
        final history = event.history;
        final key = formatter.format(history.visited);
        final Map<String, List<WebHistory>> histories = Map.from(state.histories);
        if (!histories.containsKey(key)) {
          histories[key] = [history];
        } else {
          histories[key]?.add(history);
        }
        emit(HistoryLoaded(histories: histories));
      }
    });
  }
}
