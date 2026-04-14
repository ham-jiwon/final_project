package net.koreate.cinema.services;

import java.util.List;

import net.koreate.cinema.repositories.BannerDAO;
import net.koreate.cinema.vo.BannerVO;

public class BannerService {

    private BannerDAO dao = new BannerDAO();

    public List<BannerVO> selectList() {
        return dao.selectList();
    }
    
    public void insert(BannerVO vo) {
        dao.insert(vo);
    }

    public void update(BannerVO vo) {
        dao.update(vo);
    }

    public void delete(int id) {
        dao.delete(id);
    }
    
    public void resetActive() {
        dao.resetActive();
    }    
	
}
