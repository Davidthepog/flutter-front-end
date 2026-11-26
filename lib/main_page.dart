import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_handler.dart';
import 'package:flutter_application_1/model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ApiHandler apiHandler = ApiHandler();
  List<Utenze> data = [];
  bool isLoading = true;
  String? error;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final result = await apiHandler.getUserData();
      if (!mounted) return;
      setState(() {
        data = result;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("APISTAGISTI"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        color: Colors.teal,
        textColor: Colors.white,
        padding: const EdgeInsets.all(10),
        onPressed: getData,
        child: const Text('Refresh'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(error!, textAlign: TextAlign.center),
              ),
            )
          : data.isEmpty
          ? const Center(child: Text('No users found'))
          : Column(
              children: [
                const Text(
                  "shish",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Text("${data[index].id}"),
                      title: Text(data[index].nome),
                      subtitle: Text(data[index].cognome),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
