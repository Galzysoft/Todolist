class TodoModel{

///   lets create  a constructor to be able to pass in datas to this class
 late var id;
 late var title;
 late var description;
 late var date;
 late var time;

TodoModel({required this.id,required this.title,required this.description,required this.date,required this.time});

TodoModel.fromjson( Map <dynamic,dynamic> json){
 id=json["id"];
title=json["title"];
description=json["description"];
date=json["date"];
time=json["time"];

}

}