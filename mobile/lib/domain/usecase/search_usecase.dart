import 'package:dartz/dartz.dart';
import 'package:sed/data/network/requests.dart';
import '../../data/network/failure.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class SearchUseCase implements BaseUseCase<SearchUseCaseInputs, ShowItems> {
  final Repository _repository;

  SearchUseCase(this._repository);

  @override
  Future<Either<Failure, ShowItems>> execute(SearchUseCaseInputs input) async {
    return await _repository
        .getSearchedProducts(SearchRequest(input.searchText));
  }
}

class SearchUseCaseInputs {
  String searchText;

  SearchUseCaseInputs(this.searchText);
}
