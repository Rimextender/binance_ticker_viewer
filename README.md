# binance_ticker_viewer

Binance Ticker Viewer, created using Binance Websocket API
App architecture consists of free layers: Data layer, Buisness Logic layer and Presentation layer.

## Buisness Logic layer
Two BLoCs are repsonsible for managing app state. **TickerViewerBloc** manages subscriptions to Binance Websocket API and search events, **TickerBloc** listens to events from stream of tickers. **TickerBloc** is created for each symbol, i.e. each list item has it's in **TickerBloc**.

## Data layer
Data layer has **TickerProvider**, which communicates with **BinanceTickerDataProvider** to recieve raw ticker data in **String** format. Recieved data is then decoded to json and parsed to simple **TickerDataModel**. Each **TickerBloc** subscribes to **TickerProvider**'s ticker stream and generates events to updated it's inner **TickerEntryModel** with new data.

### BinanceTickerDataProvider
**BinanceTickerDataProvider** uses [web_socket_channel](https://pub.dev/packages/web_socket_channel) package to handle connection to specified websocket. It's stream is then exposed as a broadcast stream to allow for multiple stream listeners. In addition, this class exposes methods to handle subscibtions to **Individual Symbol Mini Ticker Stream**.    

## Presentation layer
Presentation layer contains screens, components and styles (a few color constants). **TickerViewerScreen** is a simple screen which contains **TickerView** and provides **TickerRepository** and **TickerViewerBloc** for all it's descendants, and also disposes provided objects when screen's widget is disposed.

**TickerEntryWidget** consumes **TickerBloc**'s states and displays live single ticker data.

**SearchFiledWidget** does not communicate with blocs directly, instead it exposes **onChanged** method which is used in **TickerView** to generate **TickerViewerSearchEvent** for **TickerViewerBloc**.
