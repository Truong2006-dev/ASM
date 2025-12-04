package dao;

import java.util.List;

import entity.User;

public interface CrudDAO<T, K> {
	List<T> findAll();
	T findById(K id);
	void create(T item);
	void update(T item);
	void delete(K id);
	
}
