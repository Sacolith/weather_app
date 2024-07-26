import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget{
  final String location;
  const LocationWidget({super.key,required this.location});

  @override
  Widget build(BuildContext context){
    return Text(
      'Location: $location',
      style: const TextStyle(fontSize: 20)
    );
  }
}