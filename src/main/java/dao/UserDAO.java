package dao;

import java.util.List;
import dao.*;
import entity.User;

public interface UserDAO extends CrudDAO<User, String>{
	long count();
	List<User> findAll(int pageNumber, int pageSize);
	User findByEmail(String email);
}
