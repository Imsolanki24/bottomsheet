import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Overview_Screen extends StatefulWidget {
  const Overview_Screen({Key? key}) : super(key: key);

  @override
  _Overview_ScreenState createState() => _Overview_ScreenState();
}

class _Overview_ScreenState extends State<Overview_Screen> {
  var data;
  Future<void> getApi() async {
    final response = await http.get(Uri.parse(
        'https://api.stockedge.com/Api/SecurityDashboardApi/GetCompanyEquityInfoForSecurity/5051?Iang=en'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    } else {
      return data;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OverView',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue),
              ),
              Divider(
                color: Colors.grey,
                height: 50,
              ),
              SizedBox(height: 10,),
              Expanded(
                child: FutureBuilder(
                  future: getApi(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('loading');
                    } else {
                      return Column(
                        children: [
                          ReusableRow(
                            title: 'Sector',
                            value: data!['Sector'].toString(),
                          ),
                          ReusableRow(
                            title: 'Industry',
                            value: data!['Industry'].toString(),
                          ),
                          ReusableRow(
                              title: 'Market Cap.',
                              value: (data!['MCAP'].toString())),
                          ReusableRow(
                            title: 'Enterprise Value(EV)',
                            value: data!['EV'].toString(),
                          ),
                          ReusableRow(
                            title: 'Book Value/Share',
                            value: data!['BookNavPerShare'].toString(),
                          ),
                          ReusableRow(
                            title: 'Price-Earning Ratio(PE)',
                            value: data!['TTMPE'].toString(),
                          ),
                          ReusableRow(
                            title: 'PEG Ratio',
                            value: data!['PEGRatio'].toString(),
                          ),
                          ReusableRow(
                            title: 'Dividend Yield',
                            value: data!['Yield'].toString(),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class ReusableRow extends StatelessWidget {
  ReusableRow({required this.title, required this.value});

  String title, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
