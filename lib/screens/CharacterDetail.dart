import 'package:flutter/material.dart';
import 'package:mobile_test/controller/CharacterController.dart';
import 'package:mobile_test/models/Character.dart';
import 'package:mobile_test/models/Episode.dart';

class CharacterDetail extends StatefulWidget {
  late final Character character;
  CharacterDetail({required Character character}) {
    this.character = character;
  }
  @override
  State<CharacterDetail> createState() => _CharacterDetailState();
}

class _CharacterDetailState extends State<CharacterDetail> {
  CharacterController _characterController = CharacterController();
  String _firstSeen = '';

  _getEpsode() async {
    Episode episode = await _characterController.epsode(
        epsodeUrl: widget.character.episode.first);
    setState(() {
      _firstSeen = episode.name;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getEpsode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(widget.character),
    );
  }

  Widget _body(Character _character) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.50,
              child: Image.network(
                _character.image,
                fit: BoxFit.fill,
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.45,
              child: _details(_character)),
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16.0),
            child: _appBarCustom(),
          ),
        ],
      ),
    );
  }

  Widget _details(Character _character) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: new Container(
                        width: 250,
                        padding: new EdgeInsets.only(left: 16.0),
                        child: new Text(
                          _character.name,
                          overflow: TextOverflow.ellipsis,
                          style: new TextStyle(
                            fontSize: 26.0,
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: _character.status != 'Alive'
                                ? Colors.red
                                : Colors.green,
                            size: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _character.status,
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.location_history, size: 16),
                        ),
                        TextSpan(
                          text: ' Last know Location',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.grey.shade900),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 4.0),
                child: Text(_character.location.name),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.local_movies_rounded, size: 16),
                        ),
                        TextSpan(
                          text: ' First seen in',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.grey.shade900),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 4.0),
                child: Text(_firstSeen),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(Icons.male, size: 16),
                        ),
                        TextSpan(
                          text: ' Gender',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.grey.shade900),
                        ),
                      ],
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, top: 4.0),
                child: Text(_character.gender),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.android, size: 16),
                      ),
                      TextSpan(
                        text: ' Oringin',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey.shade900),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 24.0, top: 4.0, bottom: 30),
                child: Text(_character.origin.name),
              )
            ],
          )),
    );
  }

  Widget _appBarCustom() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Material(
            elevation: 4,
            borderRadius: BorderRadius.all(Radius.circular(100)),
            child: Container(
              width: 32,
              height: 32,
              child: ClipOval(
                child: Material(
                  color: Colors.white, // Button color
                  child: InkWell(
                    splashColor: Colors.grey.shade900, // Splash color
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                        width: 16,
                        height: 16,
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.grey.shade900,
                        )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
