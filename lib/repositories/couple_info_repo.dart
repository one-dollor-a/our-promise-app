import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasource/remote_data_source.dart';
import '../models/couple_profile_model.dart';

class CoupleInfoRepository {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();

  Future<CoupleProfile?> getCoupleProfile() async {
    return _remoteDataSource.getCoupleProfile();
  }

  void setCoupleProfile(CoupleProfile coupleInfoObj) {

  }
}

final coupleInfoRepositoryProvider = Provider((_) => CoupleInfoRepository());
