package dao;

import java.util.List;

import entity.Shares;

public interface SharesDAO extends CrudDAO<Shares, Long>{
	public List<Shares> findByVideoId(String videoId);
}
