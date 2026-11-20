import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_handler.dart';
import 'package:flutter_application_1/model.dart';
class MainPage extends StatefulWidget{
  const MainPage ({super.key});
  @override
  State<MainPage> createState() =>_MainPageState();

}
class _MainPageState extends State<MainPage> {
  ApiHandler apiHandler=ApiHandler();
  late List<Utenze>data=[];
  void getData() async{
    data=await apiHandler.getUserData();
    setState(() {
      
    });
  }

  @override
  void initState(){
    getData();
    super.initState();
  }


  @override
  Widget build (BuildContext context ){
    return Scaffold (appBar: AppBar(
      title: const Text("APISTAGISTI"),
      centerTitle: true,
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBar: MaterialButton(
      color: Colors.teal,
      textColor: Colors.white,
      padding: const EdgeInsets.all(10) ,
      onPressed: getData,
      child: const Text('Refresh') ),
    body: data.isEmpty ? const Center(child: CircularProgressIndicator(),): Column(
      children: [
        const Text("shish", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ListView.builder(
          shrinkWrap:true,
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index){
            return ListTile(
              leading: Text ("${data[index].id}"),
              title: Text(data[index].nome),
              subtitle: Text(data[index].cognome),

            );
          }
        )
      ],
    ));
  }
}

