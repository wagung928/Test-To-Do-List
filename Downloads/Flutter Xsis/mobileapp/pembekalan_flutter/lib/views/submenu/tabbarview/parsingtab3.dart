import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/customs/custom_snackbar.dart';
import 'package:pembekalan_flutter/models/list_users_model.dart';
import 'package:pembekalan_flutter/viewmodels/list_users_viewmodel.dart';

class ParsingTab3 extends StatefulWidget {
  const ParsingTab3({super.key});

  @override
  State<ParsingTab3> createState() => _ParsingTab3State();
}

class _ParsingTab3State extends State<ParsingTab3>
    with AutomaticKeepAliveClientMixin {
  //menampung data users
  List<Data> dataUsers = List<Data>.empty();
  //pages
  int page = 1;
  int maxPage = 1;

  //untuk scroll controller handle agar terbaca max pagging
  ScrollController scrollController = ScrollController();

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //ini artinya scroll sudah mentok bawah
        loadMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                //panggil API dan get page
                getListUsers(page);
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.black12)),
              child: Text(
                'Get List Users',
              ),
            ),
            //mengeluarkan hasil Data Users
            Expanded(
                child: ListView.builder(
              itemCount: dataUsers.length + 1, // ini loading nyisip ke dalam
              itemBuilder: (BuildContext context, int index) {
                //edit layout untuk loading
                if (index == dataUsers.length) {
                  return loadingIndicator();
                } else {
                  return Container(
                    child: InkWell(
                      onTap: () {
                        showInfoUser(dataUsers[
                            index]); //untuk spesific info per index atau custom
                      },
                      child: Card(
                        color:
                            index % 2 == 0 ? Colors.white : Colors.amberAccent,
                        margin: EdgeInsets.fromLTRB(
                            5, 30, 5, 30), //dibesarkan vertical margin
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  NetworkImage(dataUsers[index].avatar),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${dataUsers[index].firstName} ${dataUsers[index].lastName}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    '${dataUsers[index].email}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
              controller: scrollController,
            ))
          ]),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  //untuk get list user yang akan di get dari API
  void getListUsers(int page) async {
    setState(() {
      //tampilkan loading
      isLoading = true;
    });
    //memanggil API Get List Users dengan parameter Page (use Utilites beda dari tab 1 dan 2)
    // referensi:
    // https://www.dicoding.com/blog/tips-design-pattern-mvvm/
    // https://revou.co/kosakata/mvvm
    // https://ahmadsufyan.my.id/mvvm/
    ListUsersViewmodel().getDataFromAPI(context, page).then((value) {
      setState(() {
        //hilangkan loading
        isLoading = false;
        if (value != null) {
          print('Debug: $value');

          //max page
          maxPage = value.totalPages;

          if (page == 1) {
            //data awal masih kosong, isi data, maka
            //hasil tampungan data users
            dataUsers = value.data;
          } else {
            //sudah ada data sebelumnya, tambah data baru
            dataUsers.addAll(value.data);
          }
        }
      });
    });
  }

  //untuk next page data selagi masih ada
  void loadMoreData() {
    print('Load more dipanggil $page');
    if (dataUsers.isNotEmpty && page < maxPage) {
      //ambil data selanjutnya
      page += 1;
      getListUsers(page);
    } else {
      //sudah maksimal, tidak ada data lagi
    }
  }

  //tampilkan mentok error
  void showInfoUser(Data info) {
    String message = '${info.firstName} ${info.lastName}';
    ScaffoldMessenger.of(context)
        .removeCurrentSnackBar(); //hilangkan snacbar ketika back
    ScaffoldMessenger.of(context).showSnackBar(customSnackBar(message));
  }

  Widget loadingIndicator() {
    //loading type load more
    return Padding(
      padding: EdgeInsets.all(5),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 0.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
