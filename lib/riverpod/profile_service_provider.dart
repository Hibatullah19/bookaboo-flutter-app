import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/profile/data/profile_service.dart';

part 'profile_service_provider.g.dart';

@Riverpod(keepAlive: true)
ProfileService profileService(Ref ref) => ProfileService();
