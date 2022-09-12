
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jisho_app/bloc/history_bloc.dart';
import 'package:jisho_app/bloc/history_state.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        List<Widget> texts = [];
        if (state is HistoryInitial) {
          // TODO: load history
        }
        if (state is HistoryLoaded) {
          for (var h in state.histories) {
            texts.add(Text("${h.url} ${h.visited}"));
          }
        }
        return SimpleDialog(
          title: const Text('History'),
          children: texts
        );
      }
    );
  }
}