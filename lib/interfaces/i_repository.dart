abstract class IRepository<T> {
  Future add<T>(T entity);
  Future update<T>(T entity);
  Future list<T>(Function callback);
  Future select<T>(int entityPrimaryKey);
}
