package daoimpl;

import java.util.List;

import dao.SharesDAO;
import entity.Shares;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import utils.XJpa;

public class SharesDAOImpl implements SharesDAO{
	EntityManager em = XJpa.getEntityManager();

	@Override
	protected void finalize() throws Throwable {
		em.close();
	}
	
	@Override
	public List<Shares> findAll() {
		String jpql = "SELECT o FROM Shares o";
		TypedQuery<Shares> query = em.createQuery(jpql, Shares.class);
		return query.getResultList();
	}
	
	@Override
	public Shares findById(Long id) {
		return em.find(Shares.class, id);
	}
	
	@Override
	public void create(Shares item) {
		try {
			em.getTransaction().begin();
			em.persist(item);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		}
	}
	
	@Override
	public void update(Shares item) {
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
		Shares entity = em.find(Shares.class, id);
		try {
			em.getTransaction().begin();
			em.remove(entity);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		}
	}
}
