import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_and_morty/features/locations/data/models/locations.model.dart';
import 'package:rick_and_morty/internal/dependensies/get_it.dart';
import 'package:rick_and_morty/internal/helpers/text_helper.dart';

class LocationInfoScreen extends StatefulWidget {
  LocationModel locationModel;

  LocationInfoScreen({super.key, required this.locationModel});

  @override
  State<LocationInfoScreen> createState() => _LocationInfoScreenState();
}

class _LocationInfoScreenState extends State<LocationInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(240.h),
        child: AppBar(
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Stack(
            children: [
              Container(
                height: 270.h,
                width: double.infinity,
                child: Image.asset(
                  "${widget.locationModel.locationImage}",
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 236.h),
                  Container(
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.locationModel.name}",
                      style: TextHelper.s24w600,
                    ),
                    Text(
                      "${widget.locationModel.type} - ${widget.locationModel.dimension}",
                      style: TextHelper.s12w400,
                    ),
                    SizedBox(height: 36.h),
                    Text(
                      "Это планета, на которой проживает человеческая раса, и главное место для персонажей Рика и Морти. Возраст этой Земли более 4,6 миллиардов лет, и она является четвертой планетой от своей звезды.",
                      style: TextHelper.s13w400,
                    ),
                    SizedBox(height: 36.h),
                    Text("Персонажи", style: TextHelper.s18w600),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
