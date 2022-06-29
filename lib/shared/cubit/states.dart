abstract class AppStates{}

class AppInitialState extends AppStates{}

class ChangeSearchIcon extends AppStates{}

class ChangeDotIndex extends AppStates{}
class ChangeRating extends AppStates{}

class SelectCategory extends AppStates{}
class SetFavActor extends AppStates{}
class SelectSort extends AppStates{}




class PopularPeopleLoadingState extends AppStates{}
class PopularPeopleSuccessfulState extends AppStates{}
class PopularPeopleErrorState extends AppStates{}

class TrendingLoadingState extends AppStates{}
class TrendingSuccessfulState extends AppStates{}
class TrendingErrorState extends AppStates{}

class PopularMoviesLoadingState extends AppStates{}
class PopularMoviesSuccessfulState extends AppStates{}
class PopularMoviesErrorState extends AppStates{}

class CategoryMoviesLoadingState extends AppStates{}
class CategoryMoviesSuccessfulState extends AppStates{}
class CategoryMoviesErrorState extends AppStates{}


class MoviesCategoriesLoadingState extends AppStates{}
class MoviesCategoriesSuccessfulState extends AppStates{}
class MoviesCategoriesErrorState extends AppStates{}

class TvCategoriesLoadingState extends AppStates{}
class TvCategoriesSuccessfulState extends AppStates{}
class TvCategoriesErrorState extends AppStates{}
