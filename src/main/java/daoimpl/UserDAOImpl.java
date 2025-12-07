package daoimpl;

import java.util.List;

import dao.UserDAO;
import entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import utils.XJpa;

public class UserDAOImpl implements UserDAO {
	EntityManager em = XJpa.getEntityManager();

	@Override
	protected void finalize() throws Throwable {
		em.close();
	}

	@Override
	public List<User> findAll() {
		String jpql = "SELECT o FROM User o";
		TypedQuery<User> query = em.createQuery(jpql, User.class);
		return query.getResultList();
	}

	@Override
	public User findById(String id) {
		return em.find(User.class, id);
	}

	@Override
	public User findByEmail(String email) {
		String jpql = "SELECT u FROM User u WHERE u.email = :email";
		User user;
		try {
			user = em.createQuery(jpql, User.class).setParameter("email", email).getSingleResult();
		} catch (Exception e) {
			user = null;
		}
		return user;
	}

	@Override
	public void create(User item) {
		try {
			em.getTransaction().begin();
			em.persist(item);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		}
	}

	@Override
	public void update(User item) {
		try {
			em.getTransaction().begin();
			em.merge(item);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		}
	}

	@Override
	public void delete(String id) {
		User entity = em.find(User.class, id);
		try {
			em.getTransaction().begin();
			em.remove(entity);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		}
	}

	@Override
	public long count() {
		String jpql = "SELECT COUNT(o.id) FROM User o";
		TypedQuery<Long> query = em.createQuery(jpql, Long.class);
		return query.getSingleResult();
	}

	@Override
	public List<User> findAll(int pageNumber, int pageSize) {
		String jpql = "SELECT o FROM User o";
		TypedQuery<User> query = em.createQuery(jpql, User.class);

		int startPosition = pageNumber * pageSize;
		query.setFirstResult(startPosition);

		query.setMaxResults(pageSize);

		return query.getResultList();
	}
}
