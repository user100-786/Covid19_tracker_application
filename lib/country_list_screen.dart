import 'package:covid_tracker/services/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class CountryDataScreen extends StatefulWidget {
  const CountryDataScreen({super.key});

  @override
  State<CountryDataScreen> createState() => _CountryDataScreenState();
}

class _CountryDataScreenState extends State<CountryDataScreen> {
  CountryList countryList = CountryList();
  TextEditingController searchValue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.black87.withOpacity(.82)),
        body: Container(
          color: Colors.black87,
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50,right: 15,left: 15,bottom: 20),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                cursorColor: Colors.blue,
                controller: searchValue,
                onChanged: (value){
                  setState(() {
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search with country name',
                  hintStyle: const TextStyle(color: Colors.white),
                  contentPadding: const EdgeInsets.all(22),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      )
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      )
                  ),
                ),
              ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: countryList.fetchCountryList(),
                    builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                    if(snapshot.hasData){
                     return ListView.builder(
                         itemCount: snapshot.data!.length,
                         itemBuilder: (context,index){
                           String countryName = snapshot.data![index]['country'];
                           if(searchValue.text.isEmpty){
                             return Padding(
                               padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                               child: ListTile(
                                 leading: Image(
                                   height: 50,
                                   width: 50,
                                   image: NetworkImage(snapshot.data![index]['countryInfo']['flag'].toString()),
                                 ),
                                 title: Text(snapshot.data![index]['country'].toString()),
                                 titleTextStyle: const TextStyle(color: Colors.white,fontSize: 18),
                                 subtitle: Text(snapshot.data![index]['cases'].toString(),style: TextStyle(color: Colors.white.withOpacity(.8)),),
                               ),
                             );
                           }else if(countryName.toLowerCase().contains(searchValue.text.toLowerCase())){
                             return Padding(
                               padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                               child: ListTile(
                                 leading: Image(
                                   height: 50,
                                   width: 50,
                                   image: NetworkImage(snapshot.data![index]['countryInfo']['flag'].toString()),
                                 ),
                                 title: Text(snapshot.data![index]['country'].toString()),
                                 titleTextStyle: const TextStyle(color: Colors.white,fontSize: 18),
                                 subtitle: Text(snapshot.data![index]['cases'].toString(),style: TextStyle(color: Colors.white.withOpacity(.8)),),
                               ),
                             );
                           }else {
                             return Container();
                           }
                         });
                    }
                    else
                      {
                        return ListView.builder(
                          itemCount: 6,
                            itemBuilder: (context,index){
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Container(height: 50,width: 50,color: Colors.white,),
                                      title: Container(height: 10,width: 89,color: Colors.white,),
                                      subtitle: Container(height: 10,width: 89,color: Colors.white,),
                                    ),
                                  ],
                                ),
                            );
                            }
                        );
                      }
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}