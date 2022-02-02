import 'package:flutter/material.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';
import 'package:aws_polly_api/polly-2016-06-10.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final service = Polly(region: 'eu-west-1');
  // final AwsPolly _awsPolly = AwsPolly.instance(
  //   poolId: 'us-east-1:1b3e2a60-b879-467c-bbf3-6e2cc06fa066',
  //   region: AWSRegionType.USEast1,
  // );
  import 'package:http/http.dart' as http;
  void main() async{


    var credentials = new AwsClientCredentials(accessKey: <AccessKEY>, secretKey: <SecretAccessKEY);
    var outputFormat1 = OutputFormat.mp3;
    var text1 = "Hi, This is a request";
    var voiceId1 = VoiceId.salli;
    var textType1 = TextType.text;
    var url = "https://polly.us-east-1.amazonaws.com/v1/speech";

    var httpclient = new http.Client();

    final service = Polly(region: 'us-east-1', credentials: credentials, client: httpclient, endpointUrl: url);
    var resp = service.synthesizeSpeech(outputFormat: outputFormat1, text: text1, voiceId: voiceId1);
    resp.then((value) => print(value));
  }
  late WeightSliderController _controller;
  double _weight = 0;
  @override
  void initState() {
    super.initState();
    _controller = WeightSliderController(itemExtent: 40,
        initialWeight: _weight, minWeight: 0, interval: 1.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Widget painLevel(){
      if(_weight==0){
        return Text(
          "No Pain",
          style: TextStyle(fontSize: 20.0,color: Colors.cyan.shade200, fontWeight: FontWeight.w500),
        );
      }
      else if(_weight>0 && _weight<5){
        return Text(
          "Mild Pain",
          style: TextStyle(fontSize: 20.0,color: Colors.cyan.shade200, fontWeight: FontWeight.w500),
        );
      }
      else if(_weight>4 && _weight<9){
        return Text(
          "Moderate Pain",
          style: TextStyle(fontSize: 20.0,color: Colors.cyan.shade200, fontWeight: FontWeight.w500),
        );
      }
      else{
        return Text(
          "Severe Pain",
          style: TextStyle(fontSize: 20.0,color: Colors.cyan.shade200, fontWeight: FontWeight.w500),
        );
      }
    }
    return Scaffold(backgroundColor: Colors.cyan.shade100,
      appBar: AppBar(backgroundColor: Colors.cyan.shade100,
        leading:           IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back, color: Colors.black,)),
        elevation: 0,
        toolbarHeight: 150,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("You have two more sessions today",maxLines: 2, overflow: TextOverflow.ellipsis,style: TextStyle(
          color: Colors.black, fontSize: 22
        ),),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            children: [
              const SizedBox(height: 80,),
              const Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Align( alignment: Alignment.centerLeft,
                  child: Text("Pain score",style: TextStyle(
                      color: Colors.black, fontSize: 32, fontWeight: FontWeight.w600
                  ),),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Align( alignment: Alignment.centerLeft,
                  child: Text("How does your knee feel now?", style: TextStyle(
                      color: Colors.black, fontSize: 18
                  ),),
                ),
              ),

              const SizedBox(height: 100,),
              Text(
                _weight.toStringAsFixed(0),
                style: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.w500),
              ),
              Align(alignment: Alignment.centerLeft,
                child: SizedBox(width: 500,height: 70,
                  child: VerticalWeightSlider(controller: _controller,isVertical: false,maxWeight: 10,
                    decoration: const PointerDecoration(
                      width: 50.0,
                      height: 3.0,
                      largeColor: Color(0xFF898989),
                      mediumColor: Color(0xFF898989),
                      smallColor: Color(0xFF898989),
                      gap: 0.0,
                    ),
                    onChanged: (double value) {
                      setState(() {
                         _weight = value;
                      });
                    },
                    indicator: Container(
                      height: 3.0,
                      width: 70.0,
                      alignment: Alignment.centerLeft,

                      decoration: BoxDecoration(
                          color: const Color(0xFF898989),
                        borderRadius: BorderRadius.circular(30)
                      ),

                    ),
                  ),
                ),
              ),
              painLevel(),
              const SizedBox(height: 60,),
              SizedBox(width: 280,
                child: OutlinedButton(onPressed: () async {
                  // final url = await _awsPolly.getUrl(
                  //   voiceId: AWSPolyVoiceId.nicole,
                  //   input: 'This is a sample text playing through Poly!',
                  // );
                },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                      side: MaterialStateProperty.all(const BorderSide(color: Colors.black))
                    ),
                    child: const Text("Submit", style: TextStyle(
                        color: Colors.black
                    ),)
                ),
              )
            ],
          )
        ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
