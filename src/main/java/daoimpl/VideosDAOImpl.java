package daoimpl;

import java.util.List;

import dao.VideosDAO;
import entity.Videos;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import utils.XJpa;

public class VideosDAOImpl implements VideosDAO{
	EntityManager em = XJpa.getEntityManager();

	@Override
	protected void finalize() throws Throwable {
		em.close();
	}
	
	@Override
	public List<Videos> findAll() {
		String jpql = "SELECT o FROM Videos o";
		TypedQuery<Videos> query = em.createQuery(jpql, Videos.class);
		return query.getResultList();
	}
	
	@Override
	public Videos findById(String id) {
		return em.find(Videos.class, id);
	}
	
	@Override
	public void create(Videos item) {
		try {
			em.getTransaction().begin();
			em.persist(item);
			em.getTransaction().commit();
		} catch (Exception e) {
			em.getTransaction().rollback();
		}
	}
	
	@Override
	public void update(Videos item) {
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
	    try {
	        em.getTransaction().begin(); // Bắt đầu giao dịch trước
	        
	        Videos entity = em.find(Videos.class, id); // Tìm kiếm trong transaction
	        
	        if (entity != null) {
	            em.remove(entity); // Chỉ xóa nếu tìm thấy
	            em.getTransaction().commit();
	        } else {
	            // Nếu không tìm thấy thì thôi, hoặc rollback nếu cần thiết
	            em.getTransaction().rollback(); 
	        }
	    } catch (Exception e) {
	        // Nếu có lỗi thì rollback để tránh treo transaction
	        if (em.getTransaction().isActive()) {
	            em.getTransaction().rollback();
	        }
	        e.printStackTrace(); // In lỗi ra console để debug
	        throw new RuntimeException(e); // Ném lỗi ra để Servlet biết là xóa thất bại
	    }
	}
	
	@Override
	public List<Videos> findPageSize(int pageNumber, int pageSize) {
		String jpql = "SELECT v FROM Videos v WHERE v.active = true";
		TypedQuery<Videos> query = em.createQuery(jpql, Videos.class);
		query.setFirstResult(pageNumber);
		query.setMaxResults(pageSize);
		return query.getResultList();
	}
	
	@Override
	public long count() {
	    String jpql = "SELECT COUNT(v) FROM Videos v";
	    return em.createQuery(jpql, Long.class).getSingleResult();
	}
}
