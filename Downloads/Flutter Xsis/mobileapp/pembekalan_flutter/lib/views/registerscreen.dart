import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //untuk radio button
  int genderRadioValue = -1;

  //untuk list pekerjaan
  List itemPekerjaan = [
    'Designer',
    'Analis',
    'Programer',
    'Project Manager',
    'SQA',
    'PMO',
    'Database Engineer',
    'Prompt Engineer'
  ];
  String? valuePekerjaan;

  //untuk list pendidikan
  List itemPendidikan = ['SMA', 'SMK', 'D1', 'D2', 'D3', 'S1', 'S2', 'S3'];
  String? valuePendidikan;

  //untuk list Hobi
  List itemHobi = [
    'Renang',
    'Baca Buku',
    'Menyanyi',
    'Menari',
    'Lari',
    'Musik',
    'Hiking',
    'Touring'
  ];
  String? valueHobi;

  //tanggal terpilih
  DateTime tanggalTerpilih = DateTime.now();

  //tanggal lahir
  String? tanggalLahir = '-Belum Dipilih-';

  //
  bool agreeValue = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //untuk Size final
    return Container(
      color: Colors.lightBlue,
      child: Scaffold(
        //untuk buat bar atas Register Form
        appBar: AppBar(
          title: Text('Register Form'),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          backgroundColor: Colors.blueAccent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        resizeToAvoidBottomInset: false, //agar tidak keybpard cacat
        //untuk unhide keyboard use GestureDetector
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          //lanjutan untuk agar bisa scroll dengan ListView
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Nama Lengkap Anda',
                      hintStyle: TextStyle(color: Colors.orangeAccent)),
                  maxLength: 50, //untuk max input
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Usia Anda',
                      hintStyle: TextStyle(color: Colors.orangeAccent),
                      counterText: ''), //untuk menghilangkan count angka
                  maxLength: 3,
                  keyboardType: TextInputType.number, //untuk max input
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Alamat Lengkap',
                      hintStyle: TextStyle(color: Colors.orangeAccent),
                      counterText: ''), //untuk menghilangkan count angka
                  maxLength: 50,
                  keyboardType: TextInputType.text, //untuk max input
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Nomer Telepon',
                      hintStyle: TextStyle(color: Colors.orangeAccent),
                      counterText: ''), //untuk menghilangkan count angka
                  maxLength: 13,
                  keyboardType: TextInputType.phone, //untuk max input
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Email Address',
                      hintStyle: TextStyle(color: Colors.orangeAccent),
                      counterText: ''), //untuk menghilangkan count angka
                  maxLength: 50,
                  keyboardType: TextInputType.emailAddress, //untuk max input
                  onChanged: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jenis Kelamin'),
                    Row(
                      children: [
                        Radio(
                            value: 0,
                            groupValue: genderRadioValue,
                            onChanged: handleClickRadio),
                        Text('Laki-laki'),
                        Radio(
                            value: 1,
                            groupValue: genderRadioValue,
                            onChanged: handleClickRadio),
                        Text('Perempuan'),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jenis Pekerjaan'),
                    Container(
                      width: size.width,
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          items: itemPekerjaan.map((kerjaan) {
                            return DropdownMenuItem(
                              child: Text(kerjaan),
                              value: kerjaan,
                            );
                          }).toList(),
                          //untuk perubahan aksi
                          onChanged: (value) {
                            //aksi change
                            setState(() {
                              valuePekerjaan = value.toString();
                            });
                          },
                          hint: Text('-silahkan pilih-'),
                          isExpanded: true,
                          value: valuePekerjaan,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pendidikan'),
                    ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        items: itemPendidikan.map((pendidikan) {
                          return DropdownMenuItem(
                            child: Text(pendidikan),
                            value: pendidikan,
                          );
                        }).toList(),
                        //untuk perubahan aksi
                        onChanged: (value) {
                          //aksi change
                          setState(() {
                            valuePendidikan = value.toString();
                          });
                        },
                        hint: Text('-silahkan pilih-'),
                        isExpanded: false,
                        value: valuePendidikan,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hobi Anda'),
                    Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.grey),
                      child: ButtonTheme(
                        //untuk menampilkan Dropdown dari layar
                        alignedDropdown: true,
                        //untuk menampilkan Dropdown dari layar
                        child: DropdownButton(
                          items: itemHobi.map((hobi) {
                            return DropdownMenuItem(
                              child: Text(hobi),
                              value: hobi,
                            );
                          }).toList(),
                          //untuk perubahan aksi
                          onChanged: (value) {
                            //aksi change
                            setState(() {
                              valueHobi = value.toString();
                            });
                          },
                          hint: Text('-silahkan pilih-'),
                          isExpanded: true,
                          value: valueHobi,
                          //untuk merubah warna panah kecil pada dropdown
                          iconEnabledColor: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pilih Tanggal Lahir'),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              //aksi jika button ditekan
                              pilihTanggalLahir(context);
                            },
                            icon: Icon(Icons.calendar_today)),
                        Text(
                          '$tanggalLahir',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Text(
                    "Dengan melakukan Registrasi anda menyetujui semua peraturan yang berlaku oleh perushaan ini."),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CheckboxListTile(
                  value: agreeValue,
                  onChanged: (newValue) {
                    setState(() {
                      agreeValue = newValue!;
                    });
                  },
                  title: Text('Saya Setuju'),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: agreeValue ? () => sayaSetuju() : null,
                  child: Text('Register Now!'))
            ],
          ),
        ),
      ),
    );
  }

//untuk memberikan pilihan radio button
  handleClickRadio(int? value) {
    setState(() {
      genderRadioValue = value!;
      print('Nilai Radio Button = $genderRadioValue');
    });
  }

  pilihTanggalLahir(BuildContext _context) async {
    print('tampilkan date time picker');
    final DateTime? picker = await showDatePicker(
        context: _context,
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        initialDate: DateTime.now()); //ini untuk tanggalnya
    if (picker != null && picker != tanggalTerpilih) {
      setState(() {
        tanggalTerpilih = picker;
        tanggalLahir = DateFormat("dd-MM-yyyy").format(tanggalTerpilih);
      });
    }
  }

  sayaSetuju() {
    Navigator.of(context).pop();
  }
} //close code
