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

part of tinkoff_sdk_models;

/// Данные агента
class AgentData {
  static const _agentSign = 'agentSign';
  static const _operationName = 'operationName';
  static const _phones = 'phones';
  static const _receiverPhones = 'receiverPhones';
  static const _transferPhones = 'transferPhones';
  static const _operatorName = 'operatorName';
  static const _operatorAddress = 'operatorAddress';
  static const _operatorInn = 'operatorInn';

  /// Признак агента
  final AgentSign agentSign;

  /// Наименование операции
  final String? operationName;

  /// Телефоны платежного агента
  final List<String>? phones;

  /// Телефоны оператора по приему платежей
  final List<String>? receiverPhones;

  /// Телефоны оператора перевода
  final List<String>? transferPhones;

  /// Наименование оператора перевода
  final String? operatorName;

  /// Адрес оператора перевода
  final String? operatorAddress;

  /// ИНН оператора перевода
  final String? operatorInn;

  AgentData({
    required this.agentSign,
    this.operationName,
    this.phones,
    this.receiverPhones,
    this.transferPhones,
    this.operatorName,
    this.operatorAddress,
    this.operatorInn,
  });

  Map<String, dynamic> get _arguments => {
        _agentSign: agentSign.name,
        _operationName: operationName,
        _phones: phones,
        _receiverPhones: receiverPhones,
        _transferPhones: transferPhones,
        _operatorName: operatorName,
        _operatorAddress: operatorAddress,
        _operatorInn: operatorInn,
      }..removeWhere((key, value) => value == null);
}

/// Признак агента
enum AgentSign {
  /// Банковский платежный агент
  bankPayingAgent(name: 'bankPayingAgent'),

  /// Банковский платежный субагент
  bankPayingSubagent(name: 'bankPayingSubagent'),

  /// Платежный агент
  payingAgent(name: 'payingAgent'),

  /// Платежный субагент
  payingSubagent(name: 'payingSubagent'),

  /// Поверенный
  attorney(name: 'attorney'),

  /// Комиссионер
  commissionAgent(name: 'commissionAgent'),

  /// Другой тип агента
  another(name: 'another');

  final String name;

  const AgentSign({required this.name});
}
