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

/// Methods

class Method {
  static const channel = 'tinkoff_sdk';
  static const Activate activate = Activate();
  static const OpenPaymentScreen openPaymentScreen = OpenPaymentScreen();
  static const AttachCardScreen attachCardScreen = AttachCardScreen();
  static const ShowQrScreen showQrScreen = ShowQrScreen();
  static const IsNativePayAvailable isNativePayAvailable =
      IsNativePayAvailable();
  static const OpenNativePayment openNativePayment = OpenNativePayment();
  static const StartCharge startCharge = StartCharge();
  static const GetCardList getCardList = GetCardList();
}

class Activate {
  const Activate();

  String get name => 'activate';

  String get terminalKey => 'terminalKey';
  String get publicKey => 'publicKey';
  String get nativePay => 'nativePay';

  String get isDeveloperMode => 'isDeveloperMode';
  String get isDebug => 'isDebug';
  String get language => 'language';
}

class OpenPaymentScreen {
  const OpenPaymentScreen();

  String get name => 'openPaymentScreen';

  String get orderOptions => 'orderOptions';
  String get customerOptions => 'customerOptions';
  String get featuresOptions => 'featuresOptions';
}

class AttachCardScreen {
  const AttachCardScreen();

  String get name => 'attachCardScreen';

  String get customerOptions => 'customerOptions';
  String get featuresOptions => 'featuresOptions';
}

class ShowQrScreen {
  const ShowQrScreen();

  String get name => 'showQrScreen';

  String get localization => 'localizationSource';
}

class IsNativePayAvailable {
  const IsNativePayAvailable();

  String get name => 'isNativePayAvailable';
}

class OpenNativePayment {
  const OpenNativePayment();

  String get name => 'openNativePayment';

  String get orderOptions => 'orderOptions';
  String get customerOptions => 'customerOptions';
  String get merchantId => 'merchantId';
}

class StartCharge {
  const StartCharge();

  String get name => 'startCharge';
}

class GetCardList {
  const GetCardList();

  String get name => 'cardList';

  String get customerKey => 'customerKey';
}
