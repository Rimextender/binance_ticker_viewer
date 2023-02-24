import 'package:binance_ticker_viewer/bloc/ticker_bloc/ticker_bloc.dart';
import 'package:binance_ticker_viewer/presentation/styles/styles.dart';
import 'package:binance_ticker_viewer/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/ticker_entry_model.dart';

class TickerEntryWidget extends StatelessWidget {
  const TickerEntryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TickerBloc, TickerState>(
      builder: (context, state) {
        TickerEntryModel model = state.data;

        return Opacity(
          opacity: model.hasData ? 1 : 0.5,
          child: Container(
            width: 374.w,
            height: 54.w,
            margin: EdgeInsets.fromLTRB(20.w, 25.w, 20.w, 0),
            child: DefaultTextStyle(
              style: GoogleFonts.barlow(
                color: StyleColors.body2,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 121.w,
                    child: LeadingTickerColumn(model: model),
                  ),
                  Expanded(
                    child: MiddleTickerColumn(model: model),
                  ),
                  TickerEntryChangeWidget(model: model),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LeadingTickerColumn extends StatelessWidget {
  LeadingTickerColumn({
    Key? key,
    required this.model,
  }) : super(key: key);

  final TickerEntryModel model;

  final TextStyle symbolTextStyle = GoogleFonts.titilliumWeb(
    fontSize: 22.sp,
    color: StyleColors.body1,
    fontWeight: FontWeight.w600,
    height: 1.1,
  );
  final TextStyle priceSymbolTextStyle = GoogleFonts.titilliumWeb(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: model.base, style: symbolTextStyle),
          TextSpan(text: ' /${model.quote}\n', style: priceSymbolTextStyle),
          TextSpan(
            style: const TextStyle(height: 1.3),
            text: 'Vol ${Formatters.largeNumToShortString(model.volume)}',
          ),
        ],
      ),
    );
  }
}

class MiddleTickerColumn extends StatelessWidget {
  MiddleTickerColumn({
    Key? key,
    required this.model,
  }) : super(key: key);

  final TickerEntryModel model;
  final TextStyle symbolPriceTextStyle = GoogleFonts.barlow(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.40,
  );

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: const TextStyle(fontWeight: FontWeight.w600),
        children: [
          TextSpan(
            text:
                '${Formatters.displayPrice(model.close, decimals: model.close > 1 ? 2 : 4)}\n',
            style: symbolPriceTextStyle.copyWith(
              color: model.change > 0
                  ? StyleColors.positive
                  : StyleColors.negative,
            ),
          ),
          TextSpan(
              style: const TextStyle(height: 1.3),
              text:
                  '${Formatters.largeNumToShortString(model.volume * model.close)} \$'),
        ],
      ),
      textAlign: TextAlign.left,
    );
  }
}

class TickerEntryChangeWidget extends StatelessWidget {
  const TickerEntryChangeWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final TickerEntryModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.w,
      width: 103.w,
      margin: EdgeInsets.only(top: 6.w),
      decoration: BoxDecoration(
        color: model.change > 0 ? StyleColors.positive : StyleColors.negative,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        Formatters.displayChange(model.change),
        style: GoogleFonts.barlow(
          color: StyleColors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.36,
        ),
      ),
    );
  }
}
