import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app_v2_proj/extensions.dart';
import 'package:weather_app_v2_proj/model/daily_weather.model.dart';
import 'package:weather_app_v2_proj/model/location_model.dart';
import 'package:weather_app_v2_proj/model/weather_model.dart';
import 'package:weather_app_v2_proj/model/weekly_weather.model.dart';
import 'package:weather_app_v2_proj/service/get_location.dart';
import 'package:weather_app_v2_proj/service/get_current_weather.dart';
import 'package:weather_app_v2_proj/service/get_today_weather.dart';
import 'package:weather_app_v2_proj/service/get_weekly_weather.dart';
import 'package:weather_app_v2_proj/ui/current_screen.dart';
import 'package:weather_app_v2_proj/ui/today_screen.dart';
import 'package:weather_app_v2_proj/ui/weekly_screen.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  List<Location> _locations = List.empty();
  PermissionStatus? _permissionStatus;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  Location _location = Location();
  Weather _weather = Weather();
  DailyWeather _dailyWeather = DailyWeather();
  WeeklyWeather _weeklyWeather = WeeklyWeather();

  void selectLocation(Location location) {
    setState(() {
      _location = location;
      _searchController.clear();
      _isSearching = false;
    });
    fetchCurrentlyWeather();
    fetchTodayWeather();
    fetchWeeklyWeather();
  }

  void _onSearchTextChanged() async {
    String searchText = _searchController.text;
    List<Location>? fetchedWeatherList = await fetchLocationData(searchText);
    setState(() {
      if (_searchController.text.isEmpty) {
        _isSearching = false;
      } else {
        _isSearching = true;
        if (fetchedWeatherList == null) {
          showAlert(context, "Xiii deu ruim!",
              "Verifique a conexão da internet pra ver se está tudo ok e tente novamente...");
        } else if (fetchedWeatherList.isEmpty) {
          showAlert(context, "Ops!",
              "Não encontramos nenhum resultado para essa busca, tente novamente...");
        } else {
          _locations = fetchedWeatherList;
        }
      }
    });
  }

  void fetchCurrentlyWeather() async {
    Weather currentlyWeather = await fetchCurrentWeatherData(
      _location.latitude.toString().orEmpty(),
      _location.longitude.toString().orEmpty(),
    );
    setState(() {
      _weather = currentlyWeather;
    });
  }

  void fetchTodayWeather() async {
    DailyWeather dailyWeather = await fetchTodayWeatherData(
      _location.latitude.toString().orEmpty(),
      _location.longitude.toString().orEmpty(),
    );
    setState(() {
      _dailyWeather = dailyWeather;
    });
  }

  void fetchWeeklyWeather() async {
    WeeklyWeather weeklyWeather = await fetchWeeklyWeatherData(
      _location.latitude.toString().orEmpty(),
      _location.longitude.toString().orEmpty(),
    );
    setState(() {
      _weeklyWeather = weeklyWeather;
    });
  }

  void checkPermission() async {
    if (_permissionStatus == null) {
      requestLocationPermission();
    } else if (_permissionStatus!.isGranted) {
      getLocation();
    } else if (_permissionStatus!.isDenied) {
      showAlert(context, "Acesso negado!",
          "Libere o acesso a geolocalização para conseguir utilizar essa funcionalidade.",
          action: () {
        requestLocationPermission();
      });
    } else {
      showAlert(context, "Acesso negado permanentemente!",
          "Libere o acesso a geolocalização nas configurações do aplicativo para conseguir utilizar essa funcionalidade.");
    }
  }

  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    setState(() {
      _permissionStatus = status;
    });
  }

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      selectLocation(Location(
        latitude: position.latitude,
        longitude: position.longitude,
      ));
    });
  }

  @override
  void initState() {
    checkPermission();
    _searchController.addListener(_onSearchTextChanged);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => selectLocation(_locations.first)),
          title: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'search location...',
                border: InputBorder.none,
              ),
              onSubmitted: (value) => selectLocation(_locations.first)),
          actions: [
            IconButton(
              icon: const Icon(Icons.location_pin),
              tooltip: 'geolocalização',
              onPressed: () => checkPermission(),
            )
          ],
        ),
        body: Stack(
          children: [
            Opacity(
                opacity: 0.25,
                child: Image.asset('assets/clouds.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height)),
            _isSearching
                ? ListView.builder(
                    itemCount: _locations.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const Icon(Icons.apartment_rounded),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    text: TextSpan(
                                        style: const TextStyle(
                                            color: Colors.black),
                                        children: [
                                          TextSpan(
                                              text: _locations[index].name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                            text: _locations[index].toString(),
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () => selectLocation(_locations[index]));
                    },
                  )
                : TabBarView(
                    children: [
                      currentScreen(_location, _weather),
                      todayScreen(_location, _dailyWeather),
                      weeklyScreen(_location, _weeklyWeather)
                    ],
                  ),
          ],
        ),
        bottomNavigationBar: const BottomAppBar(
          child: TabBar(
            tabs: [
              Tab(
                text: 'Currently',
                icon: Icon(Icons.sunny),
              ),
              Tab(
                text: 'Today',
                icon: Icon(Icons.today),
              ),
              Tab(
                text: 'Weekly',
                icon: Icon(Icons.calendar_month),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showAlert(BuildContext context, String title, String text,
    {Function? action}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                action?.call();
              },
              child: const Text('fechar'),
            ),
          ],
        );
      });
}
