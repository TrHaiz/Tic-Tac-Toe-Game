import 'package:flutter_riverpod/flutter_riverpod.dart';

final class AppObserver extends ProviderObserver
{
  @override
  void didUpdateProvider(ProviderObserverContext context, Object? previousValue, Object? newValue) {
    print("Dữ liệu thay đổi");
    print("Provider thay đổi: ${context.provider.name ?? context.provider.runtimeType}");
    print("Dữ liệu cũ: $previousValue");
    print("Dữ liệu mới: $newValue");
  
  }
}