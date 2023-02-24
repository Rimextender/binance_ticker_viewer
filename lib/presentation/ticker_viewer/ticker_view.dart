import 'package:binance_ticker_viewer/bloc/ticker_bloc/ticker_bloc.dart';
import 'package:binance_ticker_viewer/data/models/ticker_entry_model.dart';
import 'package:binance_ticker_viewer/presentation/ticker_viewer/components/search_field_widget.dart';
import 'package:binance_ticker_viewer/presentation/ticker_viewer/components/ticker_entry_widget.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/ticker_viewer/ticker_viewer_bloc.dart';
import '../styles/styles.dart';

class TickerView extends StatelessWidget {
  const TickerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchFiledWidget(
          onChanged: (String value) {
            context
                .read<TickerViewerBloc>()
                .add(TickerViewerSearchEvent(value));
          },
        ),
        SizedBox(height: 25.w),
        Expanded(
          child: BlocBuilder<TickerViewerBloc, TickerViewerState>(
            buildWhen: (previous, current) =>
                !setEquals(previous.symbols, current.symbols),
            builder: (context, state) {
              return MultiBlocProvider(
                providers: [
                  ...state.symbols
                      .map((e) => BlocProvider<TickerBloc>(
                          create: (context) => TickerBloc(e, 'USDT')))
                      .toList()
                ],
                child: ListView(
                  children: state.symbols
                      .map<Widget>(
                        (element) =>
                            tickerEntryListItemBuilder(context, element),
                      )
                      .toList(),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget tickerEntryListItemBuilder(context, element) {
    return BlocBuilder<TickerBloc, TickerState>(
      buildWhen: (previous, current) => previous != current,
      bloc: context.read<TickerBloc>(),
      builder: (_, tickerState) {
        return BlocBuilder<TickerViewerBloc, TickerViewerState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, viewerState) {
            if (viewerState is TickerViewerFilteredState) {
              return Visibility(
                visible: tickerState.data.name.contains(viewerState.query),
                child: TickerEntryWidget(
                  model: tickerState.data,
                ),
              );
            } else {
              return TickerEntryWidget(
                model: tickerState.data,
              );
            }
          },
        );
      },
    );
  }
}
