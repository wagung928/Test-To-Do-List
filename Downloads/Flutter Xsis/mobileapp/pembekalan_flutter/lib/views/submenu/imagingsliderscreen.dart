import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pembekalan_flutter/views/submenu/detail/detailimagescreen.dart';

class ImagingSliderScreen extends StatefulWidget {
  const ImagingSliderScreen({super.key});

  @override
  State<ImagingSliderScreen> createState() => _ImagingSliderScreenState();
}

class _ImagingSliderScreenState extends State<ImagingSliderScreen> {
  @override
  Widget build(BuildContext context) {
    //items image
    final List<String> imageUrls = [
      'https://www.iclarified.com/images/news/94911/94911/94911-1280.jpg',
      'https://images.unsplash.com/photo-1698695290237-5c7be2bd52a8?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGR1Y2F0aSUyMHBhbmlnYWxlJTIwdjR8ZW58MHx8MHx8fDA%3D',
      'https://plus.unsplash.com/premium_photo-1683121710572-7723bd2e235d?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YXJ0aWZpY2lhbCUyMGludGVsbGlnZW5jZXxlbnwwfHwwfHx8MA%3D%3D',
      'https://img.freepik.com/premium-photo/modern-automobile-classic-technology-wheel-traffic_665346-119.jpg',
      'https://imgcdn.oto.com/large/gallery/exterior/67/936/bmw-s-1000-rr-slant-front-view-full-image-798854.jpg'
    ];
    //konversi items List URL agar bisa dikenali items Carousel
    final List<Widget> imageSliderItems = imageUrls
        .map(
          (item) => Container(
            margin: EdgeInsets.all(5),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: GestureDetector(
                  onTap: () {
                    //aksi jika image di tap
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailImageScreen(urlImage: item)));
                  },
                  child: Stack(
                    children: [
                      Image.network(
                        item,
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
                      Positioned(
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.black, Colors.amberAccent],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter)),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            'Gambar ke-${imageUrls.indexOf(item) + 1}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        bottom: 0,
                        left: 0,
                        right: 0,
                      )
                    ],
                  ),
                )),
          ),
        )
        .toList();

    //penampung current position
    int current_position = 0;

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Image Slider'),
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          backgroundColor: Colors.amberAccent,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider(
                items: imageSliderItems,
                options: CarouselOptions(
                  autoPlay: false,
                  aspectRatio: 2, //mid
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) {
                    setState(() {
                      //megubah posisi index
                      current_position = index;
                    });
                  },
                ))
          ],
        ),
      ),
    );
  }
}
