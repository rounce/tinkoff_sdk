/*

  Copyright © 2020 ProgressiveMobile

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.

*/

part of '../tinkoff_sdk.dart';

class TinkoffSdk {
  static TinkoffSdk? _instance;

  factory TinkoffSdk() {
    _instance ??= TinkoffSdk._private(const MethodChannel(Method.channel));
    return _instance!;
  }

  TinkoffSdk._private(this._channel);

  final MethodChannel _channel;
  String? _terminalKey;

  bool get activated => _terminalKey != null;

  /// Создание объекта для взаимодействия с SDK и передача данных продавца.
  /// Данные для активации выдаются в личном кабинете после подключения к ​Интернет-Эквайрингу.​
  ///
  /// [terminalKey] - Терминал Продавца.
  /// [publicKey] - Публичный ключ. Используется для шифрования данных.
  ///               Необходим для интеграции вашего приложения с интернет-эквайрингом Тинькофф.
  ///
  /// [configureNativePay] отвечает за возможность проведения оплат через Google Pay / ApplePay.
  /// [language] - Язык
  ///
  /// Флаги ниже используются для тестирования настроек эквайринга:
  /// [isDeveloperMode] - Тестовый URL (в этом режиме деньги с карт не списываются).
  /// [logging] - Логирование запросов.
  Future<bool> activate({
    required String terminalKey,
    required String publicKey,
    bool configureNativePay = false,
    LocalizationSource language = LocalizationSource.ru,
    bool isDeveloperMode = false,
    bool logging = false,
  }) async {
    const method = Method.activate;

    final arguments = <String, dynamic>{
      method.terminalKey: terminalKey,
      method.publicKey: publicKey,
      method.nativePay: configureNativePay,
      method.isDeveloperMode: isDeveloperMode,
      method.isDebug: logging,
      method.language: localizationString(language)
    };

    final activated = await _channel.invokeMethod<bool>(method.name, arguments) ?? false;

    if (activated) {
      _terminalKey = terminalKey;
    } else {
      throw 'Cannot activate TinkoffSDK.'
          '\nOne or more of parameters are invalid.';
    }

    return activated;
  }

  Future<List<CardData>> getCardList(String customerKey) async {
    _checkActivated();

    const method = Method.getCardList;

    final arguments = <String, dynamic>{
      method.customerKey: customerKey,
    };

    return _channel.invokeMethod(method.name, arguments).then(parseCardListResult);
  }

  /// Открытие экрана оплаты.
  /// Возвращает [true] при успешной оплате, а
  /// в случае ошибки либо отмены вернет [false].
  ///
  /// Подробное описание параметров см. в реализации
  /// [OrderOptions], [CustomerOptions], [FeaturesOptions].
  Future<TinkoffResult> openPaymentScreen({
    required OrderOptions orderOptions,
    required CustomerOptions customerOptions,
    FeaturesOptions featuresOptions = const FeaturesOptions(),
  }) async {
    _checkActivated();

    const method = Method.openPaymentScreen;

    final arguments = <String, dynamic>{
      method.orderOptions: orderOptions._arguments(),
      method.customerOptions: customerOptions._arguments(),
      method.featuresOptions: featuresOptions._arguments(),
    };

    return _channel.invokeMethod(method.name, arguments).then(parseTinkoffResult);
  }

  /// Открытие экрана привязки карт.
  ///
  /// Подробное описание параметров см. в реализации
  /// [CustomerOptions], [FeaturesOptions].
  Future<void> openAttachCardScreen({
    required CustomerOptions customerOptions,
    FeaturesOptions featuresOptions = const FeaturesOptions(),
  }) async {
    _checkActivated();

    const method = Method.attachCardScreen;

    final arguments = <String, dynamic>{
      method.customerOptions: customerOptions._arguments(),
      method.featuresOptions: featuresOptions._arguments()
    };

    return _channel.invokeMethod(method.name, arguments);
  }

  /// Экран приема оплаты по QR коду через СПБ.
  ///
  /// Результат оплаты товара покупателем по статическому QR коду не отслеживается в SDK,
  /// соответственно [Completer] завершается только при ошибке либо отмене (закрытии экрана).
  Future<TinkoffResult> showSBPQrScreen() async {
    _checkActivated();
    const method = Method.showQrScreen;

    return _channel.invokeMethod(method.name).then(parseTinkoffResult);
  }

  Future<bool> get isNativePayAvailable async {
    _checkActivated();
    final result = await _channel.invokeMethod<bool>(Method.isNativePayAvailable.name);
    return result ?? false;
  }

  Future<TinkoffResult> openNativePaymentScreen({
    required OrderOptions orderOptions,
    required CustomerOptions customerOptions,
    String? merchantId,
  }) async {
    _checkActivated();
    if (!await isNativePayAvailable) throw "Native payments isn't available.";

    const method = Method.openNativePayment;

    final arguments = <String, dynamic>{
      method.orderOptions: orderOptions._arguments(),
      method.customerOptions: customerOptions._arguments(),
      method.merchantId: merchantId ?? '',
    };

    return _channel.invokeMethod(method.name, arguments).then(parseTinkoffResult);
  }

  // TODO: implement Charge
  Future<TinkoffResult> startCharge() async {
    _checkActivated();
    const method = Method.startCharge;

    final arguments = <String, dynamic>{};

    return _channel.invokeMethod(method.name, arguments).then(parseTinkoffResult);
  }

  void _checkActivated() {
    if (_terminalKey == null) {
      throw 'TinkoffSDK is not activated.'
          '\nYou need call TinkoffSdk.activate method before calling other methods.';
    }
  }
}
