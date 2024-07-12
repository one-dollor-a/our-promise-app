import 'package:flutter/material.dart';
import 'package:our_promise/models/sample-couple-profile.model.dart';
import 'package:our_promise/services/sample-couple-profile.service.dart';

class CoupleProfileComp extends StatefulWidget {
  const CoupleProfileComp({super.key});

  @override
  _CoupleProfileCompState createState() => _CoupleProfileCompState();
}

class _CoupleProfileCompState extends State<CoupleProfileComp> {
  CoupleProfile _coupleProfile =
      CoupleProfile(id: 0, name: '', firstDate: DateTime.now());

  @override
  void initState() {
    super.initState();

    CoupleProfileService.getCoupleProfile().then((value) {
      setState(() {
        _coupleProfile = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Name: ${_coupleProfile.name}'),
          Text('D-Day: ${_coupleProfile.dDay}'),
        ],
      ),
    );
  }
}
