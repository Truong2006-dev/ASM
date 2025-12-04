package dao;

import java.util.List;

import entity.Favorites;

public interface FavoritesDAO extends CrudDAO<Favorites, Long>{
	List<Favorites> findByUserId(String userId);
	List<Favorites> findPageSize(String userId, int pageNumber, int pageSize);
	long countFavoriteByUserId(String userId);
	Favorites findByUserAndVideo(String userId, String vidId);
}
