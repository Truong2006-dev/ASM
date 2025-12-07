package daoimpl;

import java.util.List;

import dao.VideosDAO;
import entity.Videos;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import utils.XJpa;

public class VideosDAOImpl implements VideosDAO {
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
            e.printStackTrace();
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
            e.printStackTrace();
        }
    }

    @Override
    public void delete(String id) {
        try {
            em.getTransaction().begin(); 
            
            Videos entity = em.find(Videos.class, id); 
            
            if (entity != null) {
                em.remove(entity); 
                em.getTransaction().commit();
            } else {
                em.getTransaction().rollback(); 
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace(); 
            throw new RuntimeException(e); 
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

    // --- ĐÂY LÀ HÀM MỚI ĐƯỢC THÊM ---
    @Override
    public List<Videos> findByKeyword(String keyword) {
        // Tìm kiếm Video có title chứa từ khóa (LIKE)
        String jpql = "SELECT v FROM Videos v WHERE v.titile LIKE :keyword";
        
        TypedQuery<Videos> query = em.createQuery(jpql, Videos.class);
        
        // %keyword% nghĩa là tìm chữ nằm ở bất kỳ đâu trong tên
        query.setParameter("keyword", "%" + keyword + "%");
        
        return query.getResultList();
    }
}