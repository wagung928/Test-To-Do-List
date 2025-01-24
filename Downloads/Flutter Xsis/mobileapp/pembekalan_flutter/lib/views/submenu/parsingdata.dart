import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/views/submenu/tabbarview/parsingtab1.dart';
import 'package:pembekalan_flutter/views/submenu/tabbarview/parsingtab2.dart';
import 'package:pembekalan_flutter/views/submenu/tabbarview/parsingtab3.dart';

class ParsingDataScreen extends StatefulWidget {
  const ParsingDataScreen({super.key});

  @override
  State<ParsingDataScreen> createState() => _ParsingDataScreenState();
}

class _ParsingDataScreenState extends State<ParsingDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueAccent,
              title: Text(
                'Parsing Data API',
              ),
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  backgroundColor: Colors.blueAccent),
              iconTheme: IconThemeData(color: Colors.white),
              //untuk menu tab dalam tab
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: 'JSON RAW',
                    icon: Icon(Icons.data_array),
                  ),
                  Tab(
                    text: 'JSON Parse',
                    icon: Icon(Icons.data_usage),
                  ),
                  Tab(
                    text: 'API ReqRes',
                    icon: Icon(Icons.network_cell),
                  )
                ],
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                dividerColor: Colors.redAccent,
                indicatorColor: Colors.white,
              ),
            ),
            //untuk setting sub menu package didalam nya pada ParsingTab1.dart
            body: TabBarView(
                children: [ParsingTab1(), Parsingtab2(), ParsingTab3()]),
          )),
    );
  }
}
