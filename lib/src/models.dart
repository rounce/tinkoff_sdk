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

/// Models

/// [TinkoffResult] - результат выполнения вызванного метода.
/// [TinkoffResult.success] - true, если вызванный метод выполнил свою функцию.
/// [TinkoffResult.isError] - Если для результата выполнения isError помечен как true,
/// возможно, стоит показать сообщение пользователю.
/// [TinkoffResult.message] - Результирующее сообщение.
class TinkoffResult {
  static const _success = 'success';
  static const _isError = 'isError';
  static const _message = 'message';

  final bool success;
  final bool isError;
  final String message;

  TinkoffResult.error()
      : success = false,
        message = 'Native error',
        isError = true;

  TinkoffResult.fromMap(Map<String, dynamic> map)
      : success = map[_success],
        isError = map[_isError],
        message = map[_message] ?? '';
}

class CardData {
  static const _cardId = 'cardId';
  static const _pan = 'pan';
  static const _expDate = 'expDate';

  final String cardId;
  final String pan;
  final String expDate;

  CardData.fromMap(Map<String, dynamic> map)
      : cardId = map[_cardId],
        pan = map[_pan],
        expDate = map[_expDate];

  @override
  String toString() {
    return '$runtimeType("cardId":$cardId, "pan":$pan, "expDate":$expDate)';
  }
}

/// [OrderOptions] - Описание данных заказа.
/// [OrderOptions.orderId] - ID заказа в вашей системе.
/// [OrderOptions.amount] - Сумма для оплаты в копейках.
/// [OrderOptions.title] - Название платежа, видимое пользователю.
/// [OrderOptions.description] - Описание платежа, видимое пользователю.
/// [OrderOptions.saveAsParent] - Флаг определяющий является ли платеж рекуррентным.
class OrderOptions {
  static const String _orderId = 'orderId';
  static const String _amount = 'amount';
  static const String _title = 'title';
  static const String _description = 'description';
  static const String _reccurent = 'reccurentPayment';

  final String orderId;
  final int amount;
  final String title;
  final String description;
  final bool saveAsParent;

  const OrderOptions({
    required this.orderId,
    required this.amount,
    required this.title,
    required this.description,
    this.saveAsParent = false,
  });

  _arguments() =>
      {_orderId: orderId, _amount: amount, _title: title, _description: description, _reccurent: saveAsParent};
}

/// [CustomerOptions] - Данные покупателя.
/// [CustomerOptions.customerKey] - Уникальный ID пользователя для сохранения данных его карты.
/// [CustomerOptions.email] - E-mail клиента для отправки уведомлений об оплате, привязке карты.
/// [CustomerOptions.checkType] - Тип проверки при привязке карты.
/// Подробное описание находится в [CheckType].
class CustomerOptions {
  static const String _customerKey = 'customerKey';
  static const String _email = 'email';
  static const String _checkType = 'checkType';

  final String customerKey;
  final String? email;
  final CheckType checkType;

  const CustomerOptions({
    required this.customerKey,
    this.email,
    this.checkType = CheckType.hold,
  });

  Map<String, dynamic> _arguments() =>
      {_customerKey: customerKey, _email: email, _checkType: checkTypeString(checkType)};
}

/// [FeaturesOptions] - Настройки визуального отображения и функций экрана оплаты.
/// [FeaturesOptions.sbpEnabled] - Флаг подлючения СБП.
/// [FeaturesOptions.useSecureKeyboard] - Флаг использования безопасной клавиатуры (Android only).
/// [FeaturesOptions.handleCardListErrorInSdk] - Флаг, указывающий где обрабатывать ошибки получения списка карт.
/// [FeaturesOptions.enableCameraCardScanner] - Обработчик сканирования карты с помощью камеры телефона (не работает на симуляторе iOS).
/// [FeaturesOptions.darkThemeMode] - Тема экрана оплаты.
class FeaturesOptions {
  static const String _fpsEnabled = 'fpsEnabled';
  static const String _useSecureKeyboard = 'useSecureKeyboard';
  static const String _handleCardListErrorInSdk = 'handleCardListErrorInSdk';
  static const String _cameraCardScanner = 'enableCameraCardScanner';
  static const String _darkThemeMode = 'darkThemeMode';

  final bool sbpEnabled;
  final bool useSecureKeyboard;
  final bool handleCardListErrorInSdk;
  final bool enableCameraCardScanner;
  final DarkThemeMode darkThemeMode;

  const FeaturesOptions({
    this.sbpEnabled = false,
    this.useSecureKeyboard = true,
    this.handleCardListErrorInSdk = true,
    this.enableCameraCardScanner = false,
    this.darkThemeMode = DarkThemeMode.auto,
  });

  _arguments() => {
        _fpsEnabled: sbpEnabled,
        _useSecureKeyboard: useSecureKeyboard,
        _handleCardListErrorInSdk: handleCardListErrorInSdk,
        _cameraCardScanner: false, //enableCameraCardScanner, //TODO: camera flag
        _darkThemeMode: darkThemeString(darkThemeMode),
      };
}

/// [LocalizationSource] - Языковая локализация экрана.
enum LocalizationSource { ru, en }

/// [DarkThemeMode] - Режим включения темной темы.
///
/// [DarkThemeMode.auto] - Темная тема переключается в зависимости от системы устройства.
/// [DarkThemeMode.enabled] - Темная тема всегда включена.
/// [DarkThemeMode.disabled] - Темная тема всегда выключена.
enum DarkThemeMode { auto, disabled, enabled }

/// [CheckType] используется для создания платежа и привязки карты.
///
/// [CheckType.no] – Сохранить карту без проверок.
/// Если у пользователя нет сохраненных карт, то
/// в [TinkoffSdk.openAttachCardScreen] данный тип привязки может привести к ошибке.
///
/// [CheckType.hold] – При сохранении сделать списание и затем отмену на 1 руб.
/// Используется по умолчанию.
///
/// [CheckType.threeDS] (3DS) – При сохранении карты выполнить проверку 3DS.
/// Если карта поддерживает 3DS, выполняется списание и последующая отмена на 1 руб.
/// Карты, не поддерживающие 3DS, привязаны не будут.
///
/// [CheckType.threeDSHold] (3DSHOLD) – При привязке карты выполнить проверку поддержки картой 3DS.
/// Если карта поддерживает 3DS, выполняется списание и последующая отмена на 1 руб.
/// Если карта не поддерживает 3DS, выполняется списание и последующая отмена на произвольную сумму от 100 до 199 копеек.
/// Клиент будет перенаправлен на экран для ввода списанной суммы, где должен корректно указать случайную сумму.
/// В случае успешного подтверждения случайной суммы карта будет привязана.
enum CheckType { no, hold, threeDS, threeDSHold }
