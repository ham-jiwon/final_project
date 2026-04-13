package net.koreate.cinema.repositories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import net.koreate.cinema.utils.DBUtil;
import net.koreate.cinema.vo.BannerVO;

public class BannerDAO {

	public List<BannerVO> selectList() {
		
		List<BannerVO> list = new ArrayList<>();

		String sql = "SELECT id, img_name, is_active FROM banner";

	    try(Connection conn = DBUtil.getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(sql);
	        ResultSet rs = pstmt.executeQuery()) {
	
	        while(rs.next()) {
	            BannerVO b = new BannerVO();
	            b.setId(rs.getInt("id"));
	            b.setImgName(rs.getString("img_name"));
	            b.setIsActive(rs.getString("is_active"));
	            list.add(b);
	        }
	
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	
	    return list;
	}	
	
}
