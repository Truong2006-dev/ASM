package daoimpl;

import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import utils.XJpa;

public class StatsDAOImpl {
    EntityManager em = XJpa.getEntityManager();

    // TAB 1: Báo cáo tổng hợp lượt thích (Gọi SP: sp_ReportFavorites)
    public List<Object[]> getReportFavorites() {
        String sql = "{CALL sp_ReportFavorites}";
        Query query = em.createNativeQuery(sql);
        return query.getResultList();
    }

    // TAB 2: Ai thích video nào? (Gọi SP: sp_ReportFavoriteUsers)
    public List<Object[]> getReportFavoriteUsers(String videoId) {
        String sql = "{CALL sp_ReportFavoriteUsers(?)}";
        Query query = em.createNativeQuery(sql);
        query.setParameter(1, videoId);
        return query.getResultList();
    }

    // TAB 3: Ai chia sẻ cho ai? (Gọi SP: sp_ReportSharedFriends)
    public List<Object[]> getReportSharedFriends(String videoId) {
        String sql = "{CALL sp_ReportSharedFriends(?)}";
        Query query = em.createNativeQuery(sql);
        query.setParameter(1, videoId);
        return query.getResultList();
    }
}