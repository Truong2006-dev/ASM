package daoimpl;

import java.util.List;

import dao.FavoritesDAO;
import entity.Favorites;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import utils.XJpa;

public class FavoritesDAOImpl implements FavoritesDAO {
	EntityManager em = XJpa.getEntityManager();

	@Override
	protected void finalize() throws Throwable {
		em.close();
	}

	@Override
	public List<Favorites> findAll() {
		String jpql = "SELECT o FROM Favorites o";
		TypedQuery<Favorites> query = em.createQuery(jpql, Favorites.class);
		return query.getResultList();
	}

	@Override
	public Favorites findById(Long id) {
		return em.find(Favorites.class, id);
	}

	@Override
	public void create(Favorites item) {
		try {
			em.getTransaction().begin();
			em.persist(item);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		}
	}

	@Override
	public void update(Favorites item) {
		try {
			em.getTransaction().begin();
			em.merge(item);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		}
	}

	@Override
	public void delete(Long id) {
		Favorites entity = em.find(Favorites.class, id);
		try {
			em.getTransaction().begin();
			em.remove(entity);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		}
	}

	@Override
	public List<Favorites> findByUserId(String userId) {
		String jpql = "SELECT f FROM Favorites f WHERE f.user.id = :uid";
		TypedQuery<Favorites> query = em.createQuery(jpql, Favorites.class);
		query.setParameter("uid", userId);
		return query.getResultList();
	}

	@Override
	public List<Favorites> findPageSize(String userId, int pageNumber, int pageSize) {
		String jpql = "SELECT f FROM Favorites f WHERE f.user.id = :uid AND f.video.active = true";
		TypedQuery<Favorites> query = em.createQuery(jpql, Favorites.class);
		query.setParameter("uid", userId);
		query.setFirstResult(pageNumber);
		query.setMaxResults(pageSize);
		return query.getResultList();
	}

	@Override
	public long countFavoriteByUserId(String userId) {
	    String jpql = "SELECT COUNT(f) FROM Favorites f WHERE f.user.id = :uid";
	    return em.createQuery(jpql, Long.class)
	             .setParameter("uid", userId)
	             .getSingleResult();
	}
	
	@Override
	public Favorites findByUserAndVideo(String userId, String vidId) {
		String jpql = "SELECT f FROM Favorites f WHERE f.user.id = :uid AND f.video.id = :vid";
		TypedQuery<Favorites> query = em.createQuery(jpql, Favorites.class);
		query.setParameter("uid", userId);
		query.setParameter("vid", vidId);
		return query.getSingleResult();
	}
	
}
