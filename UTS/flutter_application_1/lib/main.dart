import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

const String page1 = "Home";
const String page2 = "Recipes";
const String page3 = "";
const String title = "";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: title,
      home: MyHomePage(title: title),
    );
  }
}

//edit

//

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Widget> _pages;
  late Widget _page1;
  late Widget _page2;
  late Widget _page3;
  late int _currentIndex;
  late Widget _currentPage;

  late List<String> _titles;
  late String _title1;
  late String _title2;
  late String _title3;
  late String _currentTitle;

  @override
  void initState() {
    super.initState();
    _page1 = Page1(changePage: _changeTab);
    _page2 = const Page2();
    _page3 = Page3(changePage: _changeTab);
    _pages = [_page1, _page2, _page3];
    _currentIndex = 0;
    _currentPage = _page1;
    
    _title1 = page1;
    _title2 = page2;
    _title3 = page3;
    _titles = [_title1,_title2 ,_title3 ];
    _currentTitle = _title1;
  }

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
      _currentPage = _pages[index];

      _currentTitle = _titles[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
        title: Text(_currentTitle),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            _changeTab(index);
          },
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              label: page1,
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: page2,
              icon: Icon(Icons.book),
            ),
            /*BottomNavigationBarItem(
              label: page3,
              icon: Icon(Icons.person),
            ),*/
          ]),
      drawer: Drawer(
        child: Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: <Widget>[
              _navigationItemListTitle(page1, 0),
              _navigationItemListTitle(page2, 1),
              _navigationToCategoryRoute('Category'),
              //_navigationItemListTitle(page3, 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navigationItemListTitle(String title, int index) {
    return ListTile(
      title: Text(
        '$title Page',
        style: TextStyle(color: Colors.blue[400], fontSize: 22.0),
      ),
      onTap: () {
        Navigator.pop(context);
        _changeTab(index);
      },
    );
  }

    Widget _navigationToCategoryRoute(String title) {
    return ListTile(
      title: Text(
        '$title Page',style: TextStyle(color: Colors.blue[400], fontSize: 22.0),),
        onTap: () {
        Navigator.push(
         context,
        MaterialPageRoute(builder: (context) => const CategoryRoute()),
                    );
          }
        );
    }

  //to add function here
}

class Page1 extends StatelessWidget {
  const Page1({Key? key, required this.changePage}) : super(key: key);
  final void Function(int) changePage;
  
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
    return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }
  String getSystemTime() {
      var hour1 = new DateTime.now().hour;
      var minute1 = new DateTime.now().minute;
      var second1 = new DateTime.now().second;
      var hour2 = hour1.toString();
      var minute2 = minute1.toString();
      var second2 = second1.toString();
    if (minute1<10) {
    minute2 = "0"+minute2; }
    if (hour1<10) {
    hour2 = "0"+hour2; }  
     if (second1<10) {
    second2 = "0"+minute2; }

var clock = hour2+" : "+minute2+" : "+second2+"  WIB";
      return clock.toString();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child:Container(margin: EdgeInsets.all(5),color:Colors.grey[200],
      child: Column(
                //ROW 1
              children: [
                
                  Container(
                            //color: Colors.white70,
                            height: 50,
                            width: double.infinity,
                            padding: EdgeInsets.only(left:20,right:20,),
                            child: Row (children:[                                          
                                  Expanded(flex: 5,
                                    child:Align(alignment: Alignment.centerLeft,
                                    child:Text(greeting(), style: const TextStyle(fontSize: 25),
                                ),),),
                                  Expanded(flex: 5,
                                    child:Align(alignment: Alignment.centerRight,
                                    child: StreamBuilder(stream: Stream.periodic(const Duration(seconds: 1)),
                                      builder: (context, snapshot) {
                                      return Text(getSystemTime(), style: const TextStyle(fontSize: 20),);
                                      }
                                    ),
                                ),),

                                  ],
                                ),  
                              ), 
                            

                  GestureDetector( 
                        onTap: () => changePage(1),child:
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NHx8fGVufDB8fHx8&w=1000&q=80'),
                    fit: BoxFit.fitWidth,
                    ),
                    ),
                    //color: Colors.orange[100],
                    height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.all(15.0),
                    child:  Column(
                      children: [
                        
                      Container(
                        //color: Colors.white70,
                        padding: EdgeInsets.only(left:20,top:10,),
                        height: 130,
                        width: double.infinity,
                        child: Align(alignment: Alignment.topLeft,
                          child: Text('Try Some Recipes', style: TextStyle(fontSize: 30, color: Colors.white,))
                        ),
                      ),

                        /*child:FlutterLogo(
                      size: 150.0,
                      ), */
                    

                    Container(
                      //color: Colors.white70,
                      height: 70,
                      width: double.infinity,
                      child: Align(child: SizedBox(height: 40, width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                    primary: Colors.green,),
            onPressed: () => changePage(1),
            child: const Text('Recipes',style: TextStyle(fontSize:20)),
              ),
            ),
          ),
                    ),
                    ],
                  ),
                  ),
                ),

                  Container(  
                //color: Colors.white70,
                    height: 100,
                    width: double.infinity,
                    margin: EdgeInsets.all(5),
                    child: Column(   
                        children: [ 
                          Container(
                            //color: Colors.white70,
                            height: 50,
                            width: double.infinity,
                            padding: EdgeInsets.only(left:15,),
                            child: Align(alignment: Alignment.topLeft,          
                                child: Text('Category', style: const TextStyle(fontSize: 25),
                                ),
                              ), 
                            ),
                            Container(
                            //color: Colors.blue,
                            height: 50,
                            width: double.infinity,
                            padding: EdgeInsets.only(left:10,),
                            child: Align(alignment: Alignment.topLeft,
                            child: SizedBox(height: 40, width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                    primary: Colors.green,),
                            child: const Text('Category', style: TextStyle(fontSize: 20)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CategoryRoute()),
                            );
                          },
                        ),
                          ),
                          ),
                    ),
                      ],
                    ),
                ),

                  /*Container(
                    //color: Colors.purple[100],
                    height: 100,
                    width: double.infinity,
                    margin: EdgeInsets.all(5.0),
                    child:  Column(
                      children: [*/
                        
                        Container(
                            //color: Colors.blue,
                            height: 50,
                            width: double.infinity,
                            padding: EdgeInsets.only(left:20,bottom:10,),
                            child: Align(alignment: Alignment.centerLeft,          
                                child: Text('Recomendation', style: const TextStyle(fontSize: 25),
                                ),
                              ), 
                            ),
                  
                  GestureDetector( 
                        onTap: () { Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Detail1Route()),
                                    );
                                  }, child:
                     Container(
                      decoration: BoxDecoration(
                        /*gradient: LinearGradient(
                        begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.black, Colors.white],
                    ),*/
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                    image: NetworkImage(
                      'https://kristineskitchenblog.com/wp-content/uploads/2021/04/apple-pie-1200-square-592-2.jpg'),
                    fit: BoxFit.fitWidth,
                    ),
                    ),
                      height: 200,
                      margin: EdgeInsets.all(15.0),
                      child: Column(
                        children:[
                      Container(
                        //color: Colors.white70,
                        padding: EdgeInsets.only(left:20,top:10,),
                        height: 140,
                        width: double.infinity,
                        child: Align(alignment: Alignment.topLeft,
                          child: Text('Apple Pie', style: TextStyle(fontSize: 40, color: Colors.white,))
                      ),
                        
                        /*child:FlutterLogo(
                      size: 150.0,
                      ), */
                    ),

                    Container(
                      //color: Colors.white70,
                      height: 50,
                      width: double.infinity,
                      child: Align(child: SizedBox(height: 40, width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                    primary: Colors.green,),
            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Detail1Route()),
                                    );
                                  },
            child: const Text('Detail',style: TextStyle(fontSize:20)),
              ),
            ),
          ),
                    ),
                      
                      ],
                    ),    
                  ),
                ),
                    //],
                  //),
                  //),

              ],
          ),),);
    
    
    /*Center(      
      child: Text('$page1 Page', style: Theme.of(context).textTheme.headline6),
    );*/
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(
            children: [ 

             /*Container(  
                //color: Colors.blue[100],
                    height: 120,
                    width: double.infinity,
                    margin: EdgeInsets.all(5.50),
                    child: Column(   
                        children: [ 
                          Container(
                            //color: Colors.white70,
                            height: 70,
                            width: double.infinity,
                            padding: EdgeInsets.only(left:20,top:10,),
                            child: Align(alignment: Alignment.centerLeft,          
                                child: Text('Category', style: const TextStyle(fontSize: 25),
                                ),
                              ), 
                            ),
                            Container(
                            //color: Colors.blue,
                            height: 50,
                            width: double.infinity,
                            padding: EdgeInsets.only(left:20,),
                            child: Align(alignment: Alignment.centerLeft,
                            child: SizedBox(height: 40, width: 150,
                            child: ElevatedButton(
                            child: const Text('Category', style: TextStyle(fontSize: 20)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CategoryRoute()),
                            );
                          },
                        ),
                          ),
                          ),
                    ),
                      ],
                    ),
                ),*/

              Container(
                    color: Colors.grey[200],
                    height: 1000,
                    width: double.infinity,
                    margin: EdgeInsets.all(5.0),
                    child:  Column(
                      children: [
                        Container(
                          
                            //color: Colors.white70,
                            height: 50,
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(left:10,),
                            child: Row(
                              children: [
                                Expanded(flex: 6,
                            child: Align(
                              alignment: Alignment.centerLeft,
                                child: Text('All Recipes', style: const TextStyle(fontSize: 25),
                                ),
                              ), 
                            ),
                              Expanded(flex: 4,
                                child: Container(  
                                                          
                                //color: Colors.white10,
                                height:75,
                                padding: EdgeInsets.only(right: 10,),
                                child: Align( alignment: Alignment.centerRight,
                                child: SizedBox(child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,),
                                  child:Text('Category', style: TextStyle(fontSize: 20,)),
                                      onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CategoryRoute()),
                                    );
                                  },
                                      ),   
                                    ),
                                  ),
                                  
                                ),
                                ),

                              ],
                            ),
                            ),
                            
                            Container(
                              decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                       
                            color: Colors.white,),
                            height: 70,
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            child: Row( 
                              children: [ 
                                Expanded(flex: 6,
                                      
                                child: Container(                               
                                //color: Colors.white10,
                                height:75,
                                padding: EdgeInsets.only(left:20),
                                child: Align( alignment: Alignment.centerLeft,
                                child: Text('Apple Pie', style: TextStyle(fontSize: 20,)),
                                      ),   
                                    ),
                                  ),
                                Expanded(flex: 4,
                                child: Container(                               
                                color: Colors.white10,
                                height:75,
                                padding: EdgeInsets.only(right: 10),
                                child: Align( alignment: Alignment.centerRight,
                                child: SizedBox(child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,),
                                  child:Text('Detail', style: TextStyle(fontSize: 20,)),
                                      onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Detail1Route()),
                                    );
                                  },
                                      ),   
                                    ),
                                  ),
                                ),
                                ),

                                ], 
                              ),
                            ),

                  
                            Container(
                              decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                       
                            color: Colors.white,),
                            height: 70,
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            child: Row( 
                              children: [ 
                                Expanded(flex: 6,
                                      
                                child: Container(                               
                                //color: Colors.white10,
                                height:75,
                                margin: EdgeInsets.only(bottom:10),
                                padding: EdgeInsets.only(left:20),
                                child: Align( alignment: Alignment.centerLeft,
                                child: Text('Apple Vinegar', style: TextStyle(fontSize: 20,)),
                                      ),   
                                    ),
                                  ),
                                Expanded(flex: 4,
                                child: Container(                               
                                color: Colors.white10,
                                height:75,
                                padding: EdgeInsets.only(right: 10),
                                child: Align( alignment: Alignment.centerRight,
                                child: SizedBox(child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,),
                                  child:Text('Detail', style: TextStyle(fontSize: 20,)),
                                      onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Detail2Route()),
                                    );
                                  },
                                      ),   
                                    ),
                                  ),
                                ),
                                ),

                                ], 
                              ),
                            ),
                            
                      ]
                    ),
                  ),



            ],          
          ));
    /*Center(
      child: Text('$page2 Page', style: Theme.of(context).textTheme.headline6),
    );*/
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key, required this.changePage}) : super(key: key);
  final void Function(int) changePage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$page3 Page', style: Theme.of(context).textTheme.headline6),
          ElevatedButton(
            onPressed: () => changePage(0),
            child: const Text('Switch to Home Page'),
          )
        ],
      ),
    );
  }
}


class CategoryRoute extends StatelessWidget {
  const CategoryRoute({Key? key,}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Category'),
        
         /* actions: <Widget>[
         Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: GestureDetector(
        onTap:  () => changePage(0),
        child: Icon(
          Icons.search,
          size: 26.0,
        ),
      )
    ),  ],*/
        
      ),
      body:  SingleChildScrollView(child: Container(
                    color: Colors.grey[200],
                    height: 1000,
                    width: double.infinity,
                    margin: EdgeInsets.all(5.0),
                    child:  Column(
                      children: [
                        Container(
                          color: Colors.white10,
                          height: 100,
                          child: Row(
                            children: [

                              Expanded(flex: 5,
                                child: GestureDetector( 
                                  onTap: () {
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Category1Route()),
                                    );
                                  },
                                  child: Container(                               
                                color: Colors.white10,
                                height:75,
                                margin:EdgeInsets.all(10),
                                padding: EdgeInsets.only(right: 10),
                                child: Align( alignment: Alignment.center,
                                //child: Text('Detail', style: TextStyle(fontSize: 20,)),
                                child: SizedBox(height: 100, width: 200,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                    primary: Colors.white,),
                                  child:Text('Food', style: TextStyle(fontSize: 20,color:Colors.black,)),
                                      onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Category1Route()),
                                    );
                                  },
                                  
                                      ),   
                                    ),
                                  ),
                                ),
                                ),
                                ),
                              Expanded(flex: 5,
                                child: GestureDetector( 
                                  onTap: () {
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Category2Route()),
                                    );
                                  },
                                  child: Container(                               
                                color: Colors.white10,
                                height:75,
                                margin:EdgeInsets.all(10),
                                padding: EdgeInsets.only(right: 10),
                                child: Align( alignment: Alignment.center,
                                //child: Text('Detail', style: TextStyle(fontSize: 20,)),
                                child: SizedBox(height: 100, width: 200,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                    primary: Colors.white,),
                                  child:Text('Drink', style: TextStyle(fontSize: 20,color:Colors.black,)),
                                      onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Category2Route()),
                                    );
                                  },
                                      ),   
                                    ),
                                  ),
                                ),
                                ),
                                ),

                          ])
                        ,)

                      ],
                    ),
                    
                    ),
                    ),
        /*child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),*/
      
    );
  }
}
  
class Detail1Route extends StatelessWidget {
  const Detail1Route({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Detail'),
      ),
      body: SingleChildScrollView(child: Container(color: Colors.grey[200],margin:EdgeInsets.all(5),child: Column(children: [
              Container(
                    //color: Colors.grey[200],
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.all(5.0),
                    child:  Column(
                      children: [
                        
                      Container(
                        //color: Colors.white70,
                        height: 50,
                        width: double.infinity,
                        child: Align(
                          child: Text('Apple Pie', style: TextStyle(fontSize: 25))
                        ),
                      ),
                      ],
                    ),
                  ),
      
              Container(
                decoration:BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                    image: NetworkImage(
                      'https://kristineskitchenblog.com/wp-content/uploads/2021/04/apple-pie-1200-square-592-2.jpg'),
                    fit: BoxFit.fitWidth,
                    ),
                    ),
                    //color: Colors.orange[100],
                    height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.all(15.0),
                    child:  Column(
                      children: [
                        
                      Container(
                        //color: Colors.white70,
                        height: 200,
                        width: double.infinity,
                        child: Align(
                          child: Text('', style: TextStyle(fontSize: 25))
                        ),
                      ),
                      ],
                    ),
                  ),

                    Container(
                    //color: Colors.orange[100],
                    height: 300,
                    width: double.infinity,
                    margin: EdgeInsets.only(left:5,top:5,right:5,),
                    child:  Column(
                      children: [
                        
                      Container(
                         decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20)),
                        color: Colors.white,),
                        height: 300,
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 20, top: 10,right:20,),
                        child: Column(
                          children:[
                            Container(
                              height:35,
                         child: Align(alignment: Alignment.topLeft,
                          child: Text('Ingredients', style: TextStyle(fontSize: 25))
                        ),),
                        Container(
                          height:250,
                         child: Row(children:[
                          Expanded(flex: 5,
                          child:Align(alignment: Alignment.topLeft,
                           child: Text('''Kulit Pai:\nTepung 225g\nMargarin 110g\nLard 55g\nGaram\nAir 2 sdm \nTopping:\nSusu 28g\nCinnamon\nGula''', style: TextStyle(fontSize: 15)),

                          ),),
                         Expanded(flex: 5,
                         child:Align(alignment: Alignment.topLeft,
                         child: Text('''Isi Pai:\nIrisan Apel 500g\nJus Lemon 2 sdm\nMentega Asin 28g\nGula 2,5c\nTepung 0,25c\nTepung Jagung 2,5tbsp\nKayu Manis\nPala''', style: TextStyle(fontSize: 15)),
                            
                           
                         ),),
                         ],),
                         ),
                      ],
                        ),
                      ),
                      ],
                    ),
                  ),
      
                    Container(
                    color: Colors.white,
                    height: 1000,
                    width: double.infinity,
                    margin: EdgeInsets.only(right:5,left:5,),
                    child:  Column(
                      children: [
                        
                      Container(
                        //color: Colors.white70,
                        height: 1000,
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 20, top: 10,right:20,),
                        child: Column(
                          children:[
                            Container(
                              height:35,
                         child: Align(alignment: Alignment.topLeft,
                          child: Text('Procedure', style: TextStyle(fontSize: 25))
                        ),),
                        Container(
                          height:950,
                         child: Row(children:[
                          Expanded(flex: 10,child:
                          
                          Align(alignment: Alignment.centerLeft,child:Column(
                          children: [
                            Text('''Kulit Pai:\n-Gosok Tepung, margarin, lemak babi dan garam bersama-sama sampai adonan memiliki konsistensi remah roti yang halus.
-Tambahkan 2 sendok makan air untuk membuat adonan yang lembut tapi padat Gulung pastry di atas permukaan yang sudah ditaburi tepung dengan ukuran yang Anda inginkan. Buat dua kerak.
-Tempatkan satu kulit dalam loyang pie.
\nIsi Pai:\n-Kupas dan potong apel menjadi segmen setebal hingga inci (sekitar 5 mm).
-Tambahkan jus lemon ke apel.
-Campur apel dengan tangan dengan cangkir gula dan sedikit kayu manis.
-Pindahkan segmen, dikurangi jus yang diperoleh, ke loyang. (Menghilangkan jus yang diekspresikan akan membantu mencegah pai mendidih di dalam oven.)
-Campur sisa gula, kayu manis, pala, tepung, dan tepung maizena dalam mangkuk terpisah.
-Tuangkan ini di atas apel di dalam loyang pie.
-Dot dengan mentega.
-Tutup dengan kulit lainnya.
-Kencangkan tepi dengan garpu atau jari.
-Potong ventilasi berbentuk hati atau berlian ke kerak atas.
- Olesi bagian atas pastry dengan susu dan taburi tambahan gula dan kayu manis di atasnya.
-Panggang pada suhu 350 °F (180 °C) sampai berwarna cokelat keemasan (sekitar 60 menit.)
-Keluarkan pai dari oven dan biarkan agak dingin di atas meja. Jangan, saya ulangi, JANGAN mencoba memakannya langsung dari oven, karena akan sangat panas dan dapat menyebabkan luka bakar!
-Sajikan hangat dengan es krim atau custard''', style: TextStyle(fontSize: 15)),
                          ],),),),
                         /*Expanded(flex: 5,
                         child:Align(alignment: Alignment.topLeft,
                         child: Column(
                          children: [
                            Text('Pie Filling', style: TextStyle(fontSize: 20)),
                            Text('Apple Sliced 500g\nLemon Juice 2tbsp\nSalted Butter 28g\nSugar 2,5c\nFlour 0,25c\nCornStarch 2,5tbsp\nCinnamon\nNutmeg', style: TextStyle(fontSize: 15)),
                           ],),),),*/
                         
                         ],),
                         ),
                      ],
                        ),
                      ),
                      ],
                    ),
                  ),

      ],
    ),
      ),
      ),

        /*child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),*/
      
    );
  }
}

class Detail2Route extends StatelessWidget {
  const Detail2Route({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Detail'),
      ),
      body: SingleChildScrollView(child: Container(color: Colors.grey[200],margin:EdgeInsets.all(5),child: Column(children: [
              Container(
                    //color: Colors.grey[200],
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.all(5.0),
                    child:  Column(
                      children: [
                        
                      Container(
                        //color: Colors.white70,
                        height: 50,
                        width: double.infinity,
                        child: Align(
                          child: Text('Apple Vinegar', style: TextStyle(fontSize: 25))
                        ),
                      ),
                      ],
                    ),
                  ),
      
              Container(
                decoration:BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                    image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBR7L6Bt1X1mJ5IHnvc_0A3nGho0VSOQzVykEqCJaOgA3koay8GGrcB87vmvmEttv2Xjc&usqp=CAU'),
                    fit: BoxFit.fitWidth,
                    ),
                    ),
                    //color: Colors.orange[100],
                    height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.all(15.0),
                    child:  Column(
                      children: [
                        
                      Container(
                        //color: Colors.white70,
                        height: 200,
                        width: double.infinity,
                        child: Align(
                          child: Text('', style: TextStyle(fontSize: 25))
                        ),
                      ),
                      ],
                    ),
                  ),

                    Container(
                    //color: Colors.orange[100],
                    height: 300,
                    width: double.infinity,
                    margin: EdgeInsets.only(left:5,top:5,right:5,),
                    child:  Column(
                      children: [
                        
                      Container(
                         decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20)),
                        color: Colors.white,),
                        height: 300,
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 20, top: 10,right:20,),
                        child: Column(
                          children:[
                            Container(
                              height:35,
                         child: Align(alignment: Alignment.topLeft,
                          child: Text('Ingredients', style: TextStyle(fontSize: 25))
                        ),),
                        Container(
                          height:100,
                         child: Row(children:[
                          Expanded(flex: 10,
                          child:Align(alignment: Alignment.topLeft,
                           child: Text('''4 kilogram (8.8 lb) apel''', style: TextStyle(fontSize: 15)),

                          ),),
                         /*Expanded(flex: 5,
                         child:Align(alignment: Alignment.topLeft,
                         child: Text('''Pie Filling:\nApple Sliced 500g\nLemon Juice 2tbsp\nSalted Butter 28g\nSugar 2,5c\nFlour 0,25c\nCornStarch 2,5tbsp\nCinnamon\nNutmeg''', style: TextStyle(fontSize: 15)),
                         ),),*/
                         ],),
                         ),
                        Container(
                              height:35,
                         child: Align(alignment: Alignment.topLeft,
                          child: Text('Equipment', style: TextStyle(fontSize: 25))
                        ),),
                        Container(
                          height:100,
                         child: Row(children:[
                          Expanded(flex: 10,
                          child:Align(alignment: Alignment.topLeft,
                           child: Text('''-Dua 3 liter (0,66 imp gal; 0,79 US gal) fermentor (bisa botol besar atau ember plastik food grade)
-Apple crusher atau pembuat jus
-Selang siphon food grade (dari toko perangkat keras atau toko homebrew)''', style: TextStyle(fontSize: 15)),

                          ),),
                         /*Expanded(flex: 5,
                         child:Align(alignment: Alignment.topLeft,
                         child: Text('''Pie Filling:\nApple Sliced 500g\nLemon Juice 2tbsp\nSalted Butter 28g\nSugar 2,5c\nFlour 0,25c\nCornStarch 2,5tbsp\nCinnamon\nNutmeg''', style: TextStyle(fontSize: 15)),
                         ),),*/
                         ],),
                         ),

                      ],
                        ),
                      ),
                      ],
                    ),
                  ),
      
                    Container(
                    color: Colors.white,
                    height: 1000,
                    width: double.infinity,
                    margin: EdgeInsets.only(right:5,left:5,),
                    child:  Column(
                      children: [
                        
                      Container(
                        //color: Colors.white70,
                        height: 1000,
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 20, top: 10,right:20,),
                        child: Column(
                          children:[
                            Container(
                              height:35,
                         child: Align(alignment: Alignment.topLeft,
                          child: Text('Procedure', style: TextStyle(fontSize: 25))
                        ),),
                        Container(
                          height:950,
                         child: Row(children:[
                          Expanded(flex: 10,child:
                          
                          Align(alignment: Alignment.centerLeft,child:Column(
                          children: [
                            Text('''Cuci apel untuk menghilangkan kotoran yang terlihat, dan potong bagian yang memar atau terkena burung.
Hancurkan apel, atau masukkan melalui pembuat jus, dan kumpulkan jus di salah satu fermentor.
Tutup fermentor dengan kain, atau tutup lubangnya dengan kapas jika sempit, untuk mencegah debu dan serangga. Jangan khawatir fermentornya tidak penuh, seperti yang seharusnya untuk membuat sari buah apel. Dengan cuka, ruang udara baik, karena membawa oksigen ke bakteri.
Sisihkan tempat untuk berfermentasi, tidak terlalu hangat atau terlalu dingin (sekitar 18–22 °C (64–72 °F)).
Biarkan jus berfermentasi. Seharusnya mulai berbuih dalam beberapa hari. Catat kemajuannya, sehingga Anda dapat mengetahui kapan fermentasi telah mencapai puncaknya dan melambat.
Saat fermentasi melambat dan tidak menggelegak begitu kuat, sedot ke fermentor lain dengan hati-hati. Cobalah untuk tidak mendapatkan terlalu banyak kotoran yang mengendap di bagian bawah, atau buih di atasnya—tujuannya adalah untuk mendapatkan sari buah apel yang bening tanpa terlalu banyak potongan yang mengambang!
Sisihkan fermentor kedua untuk difermentasi selama dua hingga tiga bulan. Setelah beberapa saat, Anda akan melihat lapisan putih terbentuk di atasnya. Jangan putus asa—ini adalah induk cuka , sebuah struktur yang dibangun oleh bakteri pembuat cuka ( acetobacter )
Setelah beberapa bulan, Anda dapat mengambil dua pertiga cuka untuk digunakan, dan mengisinya dengan sari buah apel segar dan bening yang dibuat di fermentor pertama.''', style: TextStyle(fontSize: 15)),
                          ],),),),
                         /*Expanded(flex: 5,
                         child:Align(alignment: Alignment.topLeft,
                         child: Column(
                          children: [
                            Text('Pie Filling', style: TextStyle(fontSize: 20)),
                            Text('Apple Sliced 500g\nLemon Juice 2tbsp\nSalted Butter 28g\nSugar 2,5c\nFlour 0,25c\nCornStarch 2,5tbsp\nCinnamon\nNutmeg', style: TextStyle(fontSize: 15)),
                           ],),),),*/
                         
                         ],),
                         ),
                      ],
                        ),
                      ),
                      ],
                    ),
                  ),

      ],
    ),
      ),
      ),

        /*child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),*/
      
    );
  }
}



class Category1Route extends StatelessWidget {
  const Category1Route({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Category'),
      ),
      body: SingleChildScrollView(child: Container(
                    color: Colors.grey[200],
                    height: 1000,
                    width: double.infinity,
                    margin: EdgeInsets.all(5.0),
                    child:  Column(
                      children: [
                        Container(
                            //color: Colors.white70,
                            height: 75,
                            width: double.infinity,
                            padding: EdgeInsets.only(left:20,),
                            child: Align(
                              alignment: Alignment.centerLeft,
                                child: Text('Food', style: const TextStyle(fontSize: 25),
                                ),
                              ), 
                            ),
                            
                            Container(
                              decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                       
                            color: Colors.white,),
                            height: 70,
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            child: Row( 
                              children: [ 
                                Expanded(flex: 6,
                                      
                                child: Container(                               
                                //color: Colors.white10,
                                height:75,
                                padding: EdgeInsets.only(left:20),
                                child: Align( alignment: Alignment.centerLeft,
                                child: Text('Apple Pie', style: TextStyle(fontSize: 20,)),
                                      ),   
                                    ),
                                  ),
                                Expanded(flex: 4,
                                child: Container(                               
                                color: Colors.white10,
                                height:75,
                                padding: EdgeInsets.only(right: 10),
                                child: Align( alignment: Alignment.centerRight,
                                child: SizedBox(child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,),
                                  child:Text('Detail', style: TextStyle(fontSize: 20,)),
                                      onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Detail1Route()),
                                    );
                                  },
                                      ),   
                                    ),
                                  ),
                                ),
                                ),

                                ], 
                              ),
                            ),

                            
                      ],
                    ),
                  ), 
      ),    

      /*Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),*/
    );
  }
}

class Category2Route extends StatelessWidget {
  const Category2Route({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Category'),
      ),
      body: SingleChildScrollView(child: Container(
                    color: Colors.grey[200],
                    height: 1000,
                    width: double.infinity,
                    margin: EdgeInsets.all(5.0),
                    child:  Column(
                      children: [
                        Container(
                            //color: Colors.white70,
                            height: 75,
                            width: double.infinity,
                            padding: EdgeInsets.only(left:20,),
                            child: Align(
                              alignment: Alignment.centerLeft,
                                child: Text('Drinks', style: const TextStyle(fontSize: 25),
                                ),
                              ), 
                            ),
                            
                            Container(
                              decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                       
                            color: Colors.white,),
                            height: 70,
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            child: Row( 
                              children: [ 
                                Expanded(flex: 6,
                                      
                                child: Container(                               
                                //color: Colors.white10,
                                height:75,
                                margin: EdgeInsets.only(bottom:10),
                                padding: EdgeInsets.only(left:20),
                                child: Align( alignment: Alignment.centerLeft,
                                child: Text('Apple Vinegar', style: TextStyle(fontSize: 20,)),
                                      ),   
                                    ),
                                  ),
                                Expanded(flex: 4,
                                child: Container(                               
                                color: Colors.white10,
                                height:75,
                                padding: EdgeInsets.only(right: 10),
                                child: Align( alignment: Alignment.centerRight,
                                child: SizedBox(child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,),
                                  child:Text('Detail', style: TextStyle(fontSize: 20,)),
                                      onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Detail2Route()),
                                    );
                                  },
                                      ),   
                                    ),
                                  ),
                                ),
                                ),

                                ], 
                              ),
                            ),

                            
                      ],
                    ),
                  ),     
      ),

      /*Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),*/
    );
  }
}