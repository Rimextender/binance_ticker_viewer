import 'package:binance_ticker_viewer/data/repository/ticker_repository.dart';
import 'package:binance_ticker_viewer/presentation/ticker_viewer/ticker_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/ticker_viewer/ticker_viewer_bloc.dart';
import '../styles/styles.dart';

class TickerViewerScreen extends StatefulWidget {
  const TickerViewerScreen({super.key});

  @override
  State<TickerViewerScreen> createState() => _TickerViewerScreenState();
}

class _TickerViewerScreenState extends State<TickerViewerScreen> {
  final Set<String> symbols = const {"BTC", "ETH", "XRP", "BNB"};
  late final TickerViewerBloc bloc;
  final TickerRepository repository = TickerRepository();

  _TickerViewerScreenState() {
    bloc = TickerViewerBloc(symbols, repository);
  }

  @override
  void dispose() {
    bloc.close();
    repository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleColors.background,
      extendBodyBehindAppBar: false,
      body: SafeArea(
        child: RepositoryProvider.value(
          value: repository,
          child: BlocProvider.value(
            value: bloc,
            child: const TickerView(),
          ),
        ),
      ),
    );
  }
}
