

import 'package:hive_flutter/adapters.dart';

part 'profileModel.g.dart';

@HiveType(typeId: 2)

class Profilemodel {

@HiveField(0)
String? userImage;

@HiveField(1)
String? name;

@HiveField(2)
String?email;
  
@HiveField(3)
String? phone;

@HiveField(4)
String? userName;

Profilemodel(
 
  { this.userImage,
   this.name,
   this.email,
   this.phone,
   this.userName,
 }
 
);
}