class TodoModel{

///   lets create  a constructor to be able to pass in datas to this class

 late var title;
 late var description;
 late var date;
 late var time;

TodoModel({required this.title,required this.description,required this.date,required this.time});

TodoModel.fromjson( Map <dynamic,dynamic> json){
title=json["title"];
description=json["description"];
date=json["date"];
time=json["time"];

}

}