import 'package:binance_ticker_viewer/bloc/ticker_bloc/ticker_bloc.dart';
import 'package:binance_ticker_viewer/data/repository/ticker_repository.dart';
import 'package:binance_ticker_viewer/presentation/ticker_viewer/components/search_field_widget.dart';
import 'package:binance_ticker_viewer/presentation/ticker_viewer/components/ticker_entry_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/ticker_viewer/ticker_viewer_bloc.dart';

class TickerView extends StatefulWidget {
  const TickerView({super.key});

  @override
  State<TickerView> createState() => _TickerViewState();
}

class _TickerViewState extends State<TickerView> {
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
              return ListView(
                children: state.symbols
                    .map<Widget>(
                      (element) => BlocProvider<TickerBloc>(
                        create: (context) => TickerBloc(
                            element, 'USDT', context.read<TickerRepository>()),
                        child: tickerEntryListItemBuilder(context, element),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        )
      ],
    );
  }

  Widget tickerEntryListItemBuilder(BuildContext context, String element) {
    return BlocBuilder<TickerViewerBloc, TickerViewerState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, viewerState) {
        if (viewerState is TickerViewerFilteredState) {
          return Visibility(
            visible: element.toLowerCase().contains(viewerState.query),
            child: const TickerEntryWidget(),
          );
        } else {
          return const TickerEntryWidget();
        }
      },
    );
  }
}
