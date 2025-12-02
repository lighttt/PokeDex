import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedexapp/core/network/network_info.dart';

import '../../helpers/mocks.dart';

void main() {
  late MockConnectivity mockConnectivity;
  late NetworkInfoImpl networkInfo;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(mockConnectivity);
  });

  test('isConnected returns true when connectivity is not none', () async {
    when(() => mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.wifi]);

    final result = await networkInfo.isConnected;

    expect(result, isTrue);
    verify(() => mockConnectivity.checkConnectivity()).called(1);
  });

  test('connectionStream maps list stream to first result', () async {
    when(() => mockConnectivity.onConnectivityChanged)
        .thenAnswer((_) => Stream<List<ConnectivityResult>>.fromIterable([
              [ConnectivityResult.mobile]
            ]));

    expectLater(
        networkInfo.connectionStream, emitsInOrder([ConnectivityResult.mobile]));
  });
}
