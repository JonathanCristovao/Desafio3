import 'package:socialmidia/data/http/http.dart';
import 'package:socialmidia/data/models/models.dart';
import 'package:socialmidia/data/usecases/usecases.dart';
import 'package:socialmidia/domain/entities/entities.dart';

class RemoteLoadPeople implements LoadPeople {
  final HttpClient httpClient;
  final String url;

  RemoteLoadPeople({
    required this.httpClient,
    required this.url,
  });

  @override
  Future<List<PersonEntity>> loadPeople() async {
    final List<dynamic> response =
        await httpClient.request(url: url, method: 'get');

    return response
        .map((person) =>
            RemotePersonModel.fromJson(person as Map<String, dynamic>)
                .toEntity())
        .toList();
  }
}
