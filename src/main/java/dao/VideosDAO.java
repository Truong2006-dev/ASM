package dao;

import java.util.List;

import entity.Videos;

public interface VideosDAO extends CrudDAO<Videos, String>{
	List<Videos> findPageSize(int pageNumber, int pageSize);
	long count();
	
}
