import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_promise/models/couple_models.dart';

import '../datasource/remote_data_source.dart';
import '../models/couple_profile_model.dart';

class CoupleInfoRepository {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();

  Future<CoupleInfoResponse?> getCoupleProfile() async {
    return _remoteDataSource.getCoupleInfo();
  }

  void setCoupleProfile(CoupleProfile coupleInfoObj) {

  }
}

final coupleInfoRepositoryProvider = Provider((_) => CoupleInfoRepository());
