/*

  Copyright © 2024 ProgressiveMobile

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

/// Methods

class Method {
  static const channel = 'tinkoff_sdk';
  static const Activate activate = const Activate();
  static const OpenPaymentScreen openPaymentScreen = const OpenPaymentScreen();
  static const AttachCardScreen attachCardScreen = const AttachCardScreen();
  static const ShowStaticQrScreen showStaticQrScreen =
      const ShowStaticQrScreen();
  static const ShowDynamicQrScreen showDynamicQrScreen =
      const ShowDynamicQrScreen();
  static const StartCharge startCharge = const StartCharge();
  static const GetCardList getCardList = const GetCardList();
}

class Activate {
  const Activate();

  String get name => 'activate';

  String get terminalKey => 'terminalKey';
  String get publicKey => 'publicKey';

  String get isDeveloperMode => 'isDeveloperMode';
  String get logging => 'logging';
}

class OpenPaymentScreen {
  const OpenPaymentScreen();

  String get name => 'openPaymentScreen';

  String get orderOptions => 'orderOptions';
  String get customerOptions => 'customerOptions';
  String get featuresOptions => 'featuresOptions';
  String get receipt => 'receipt';
  String get token => 'token';
  String get terminalKey => 'terminalKey';
  String get publicKey => 'publicKey';
  String get ffdVersion => 'ffdVersion';
}

class AttachCardScreen {
  const AttachCardScreen();

  String get name => 'attachCardScreen';

  String get terminalKey => 'terminalKey';
  String get publicKey => 'publicKey';
  String get customerOptions => 'customerOptions';
  String get featuresOptions => 'featuresOptions';
}

class ShowStaticQrScreen {
  const ShowStaticQrScreen();

  String get name => 'showStaticQrScreen';
  String get featuresOptions => 'featuresOptions';
}

class ShowDynamicQrScreen {
  const ShowDynamicQrScreen();

  String get name => 'showDynamicQrScreen';

  String get terminalKey => 'terminalKey';
  String get publicKey => 'publicKey';
  String get paymentFlow => 'paymentFlow';
  String get orderOptions => 'orderOptions';
  String get customerOptions => 'customerOptions';
  String get featuresOptions => 'featuresOptions';
  String get paymentId => 'paymentId';
  String get amount => 'amount';
  String get orderId => 'orderId';
  String get successUrl => 'successUrl';
  String get failureUrl => 'failureUrl';
  String get paymentData => 'paymentData';
}

class StartCharge {
  const StartCharge();

  String get name => 'startCharge';
}

class GetCardList {
  const GetCardList();

  String get name => 'cardList';

  String get terminalKey => 'terminalKey';
  String get publicKey => 'publicKey';
  String get customerOptions => 'customerOptions';
  String get featuresOptions => 'featuresOptions';
}
