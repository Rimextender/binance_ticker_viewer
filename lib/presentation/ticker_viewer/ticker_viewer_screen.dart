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

class TickerViewerScreen extends StatelessWidget {
  const TickerViewerScreen({super.key});

  final Set<String> symbols = const {"BTC", "ETH", "XRP", "BNB"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleColors.background,
      extendBodyBehindAppBar: false,
      body: SafeArea(
        child: Column(
          children: [
            SearchFiledWidget(
              onChanged: (String value) {},
            ),
            SizedBox(height: 25.w),
            Expanded(
              child: BlocBuilder<TickerViewerBloc, TickerViewerState>(
                bloc: TickerViewerBloc(symbols),
                buildWhen: (previous, current) =>
                    setEquals(previous.symbols, current.symbols),
                builder: (context, state) {
                  return ListView(
                    children: state.symbols.map<Widget>(
                      (element) {
                        return BlocBuilder<TickerBloc, TickerState>(
                          buildWhen: (previous, current) => previous != current,
                          builder: (context, state) {
                            return TickerEntryWidget(
                              model: state.data,
                            );
                          },
                        );
                      },
                    ).toList(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
