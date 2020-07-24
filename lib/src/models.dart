
part of tinkoff_sdk;

/// Models

/// [OrderOptions] - Описание данных заказа.
/// [OrderOptions.orderId] - ID заказа в вашей системе.
/// [OrderOptions.amount] - Сумма для оплаты в копейках.
/// [OrderOptions.title] - Название платежа, видимое пользователю.
/// [OrderOptions.description] - Описание платежа, видимое пользователю.
/// [OrderOptions.reccurentPayment] - Флаг определяющий является ли платеж рекуррентным.
class OrderOptions {
  static const String _orderId = 'orderId';
  static const String _amount = 'amount';
  static const String _title = 'title';
  static const String _description = 'description';
  static const String _reccurent = 'reccurentPayment';

  final int orderId;
  final int amount;
  final String title;
  final String description;
  final bool reccurentPayment;

  OrderOptions({
    @required this.orderId,
    @required this.amount,
    @required this.title,
    @required this.description,
    this.reccurentPayment = false,
  }) :
      assert(reccurentPayment != null, "ReccurentPayment cannot be null");

  _arguments() => {
    _orderId: orderId,
    _amount: amount,
    _title: title,
    _description: description,
    _reccurent: reccurentPayment ?? false,
  };
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
  final String email;
  final CheckType checkType;

  CustomerOptions({
    @required this.customerKey,
    this.email,
    this.checkType = CheckType.no,
  }) :
      assert(checkType != null, "CheckType cannot be null");

  _arguments() => {
    _customerKey: customerKey,
    _email: email,
    _checkType: _CheckType(checkType).toString()
  };
}

/// [FeaturesOptions] - Настройки визуального отображения и функций экрана оплаты.
/// [FeaturesOptions.sbpEnabled] - Флаг подлючения СБП.
/// [FeaturesOptions.useSecureKeyboard] - Флаг использования безопасной клавиатуры (Android only).
/// [FeaturesOptions.localizationSource] - Языковая локализация экрана.
/// [FeaturesOptions.handleCardListErrorInSdk] - Флаг, указывающий где обрабатывать ошибки получения списка карт.
/// [FeaturesOptions.enableCameraCardScanner] - Обработчик сканирования карты с помощью камеры телефона (не работает на симуляторе iOS).
/// [FeaturesOptions.darkThemeMode] - Тема экрана оплаты.
class FeaturesOptions {
  static const String _fpsEnabled = 'fpsEnabled';
  static const String _useSecureKeyboard = 'useSecureKeyboard';
  static const String _localizationSource = 'localizationSource';
  static const String _handleCardListErrorInSdk = 'handleCardListErrorInSdk';
  static const String _cameraCardScanner = 'enableCameraCardScanner';
  static const String _darkThemeMode = 'darkThemeMode';

  final bool sbpEnabled;
  final bool useSecureKeyboard;
  final LocalizationSource localizationSource;
  final bool handleCardListErrorInSdk;
  final bool enableCameraCardScanner;
  final DarkThemeMode darkThemeMode;

  FeaturesOptions({
    this.sbpEnabled = false,
    this.useSecureKeyboard = true,
    this.localizationSource = LocalizationSource.ru,
    this.handleCardListErrorInSdk = true,
    this.enableCameraCardScanner = false,
    this.darkThemeMode = DarkThemeMode.auto,
  }) : 
      assert(sbpEnabled != null, 'SBP boolean cannot be null'),
      assert(useSecureKeyboard != null, 'SecureKeyboard boolean cannot be null'),
      assert(localizationSource != null, 'LocalizationSource cannot be null'),
      assert(handleCardListErrorInSdk != null, 'HandleError boolean cannot be null'),
      assert(enableCameraCardScanner != null, 'EnableCamera boolean cannot be null'),
      assert(darkThemeMode != null, 'DarkThemeMode cannot be null');

  _arguments() => {
    _fpsEnabled: sbpEnabled ?? false,
    _useSecureKeyboard: useSecureKeyboard ?? true,
    _localizationSource: _LocalizationSource(localizationSource).toString(),
    _handleCardListErrorInSdk: handleCardListErrorInSdk ?? true,
    //_cameraCardScanner: enableCameraCardScanner ?? false, TODO: camera flag
    _darkThemeMode: _DarkThemeMode(darkThemeMode).toString(),
  };
}

/// [LocalizationSource] - Языковая локализация экрана.
enum LocalizationSource {
  ru, en
}

class _LocalizationSource {
  final LocalizationSource source;

  _LocalizationSource(this.source);

  @override
  String toString() {
    switch (source) {
      case LocalizationSource.en: {
        return 'EN';
      }
      case LocalizationSource.ru:
      default: {
        return 'RU';
      }
    }
  }
}

/// [DarkThemeMode] - Режим включения темной темы.
///
/// [DarkThemeMode.auto] - Темная тема переключается в зависимости от системы устройства.
/// [DarkThemeMode.enabled] - Темная тема всегда включена.
/// [DarkThemeMode.disabled] - Темная тема всегда выключена.
enum DarkThemeMode {
  auto, disabled, enabled
}

class _DarkThemeMode {
  final DarkThemeMode mode;

  _DarkThemeMode(this.mode);

  @override
  String toString() {
    switch (mode) {
      case DarkThemeMode.enabled: {
        return 'ENABLED';
      }
      case DarkThemeMode.disabled: {
        return 'DISABLED';
      }
      case DarkThemeMode.auto:
      default: {
        return 'AUTO';
      }
    }
  }
}

/// [CheckType] используется для создания платежа и привязки карты.
///
/// [CheckType.no] – Сохранить карту без проверок.
///
/// [CheckType.hold] – При сохранении сделать списание и затем отмену на 1 руб.
///
/// [CheckType.threeDS] (3DS) – При сохранении карты выполнить проверку 3DS.
/// Если карта поддерживает 3DS, выполняется списание и последующая отмена на 1 руб.
/// Карты, не поддерживающие 3DS, привязаны не будут.
///
/// [CheckType.threeDS_hold] (3DSHOLD) – При привязке карты выполнить проверку поддержки картой 3DS.
/// Если карта поддерживает 3DS, выполняется списание и последующая отмена на 1 руб.
/// Если карта не поддерживает 3DS, выполняется списание и последующая отмена на произвольную сумму от 100 до 199 копеек.
/// Клиент будет перенаправлен на экран для ввода списанной суммы, где должен корректно указать случайную сумму.
/// В случае успешного подтверждения случайной суммы карта будет привязана.
enum CheckType {
  no,
  hold,
  threeDS,
  threeDS_hold
}

class _CheckType {
  final CheckType type;

  _CheckType(this.type);
  
  @override
  String toString() {
    switch (type) {
      case CheckType.hold: {
        return 'HOLD';
      }
      case CheckType.threeDS: {
        return '3DS';
      }
      case CheckType.threeDS_hold: {
        return '3DSHOLD';
      }
      case CheckType.no:
      default: {
        return 'NO';
      }
    }
  }
} 