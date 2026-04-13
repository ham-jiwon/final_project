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
	
	public void insert(BannerVO vo) {
	    String sql = "INSERT INTO banner(id, img_name, is_active) VALUES (banner_seq.NEXTVAL, ?, ?)";

	    try(Connection conn = DBUtil.getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, vo.getImgName());
	        pstmt.setString(2, vo.getIsActive());

	        pstmt.executeUpdate();

	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	}
	
	public void resetActive(){
	    String sql = "UPDATE banner SET is_active = 'N'";

	    try(Connection conn = DBUtil.getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.executeUpdate();

	    } catch(Exception e){
	        e.printStackTrace();
	    }
	}	
	
	public void update(BannerVO vo) {
	    String resetSql = "UPDATE banner SET is_active = 'N'";
	    String updateSql = "UPDATE banner SET is_active = 'Y' WHERE id = ?";

	    try(Connection conn = DBUtil.getConnection()) {
	        // 1️) 전체 OFF
	        PreparedStatement pstmt1 = conn.prepareStatement(resetSql);
	        pstmt1.executeUpdate();
	        
	        // 2️) 선택한 것만 ON
	        PreparedStatement pstmt2 = conn.prepareStatement(updateSql);
	        pstmt2.setInt(1, vo.getId());
	        pstmt2.executeUpdate();	        

	    } catch(Exception e) {
	        e.printStackTrace();
	    }		
	}
	
	public void delete(int id) {
	    String sql = "DELETE FROM banner WHERE id = ?";

	    try(Connection conn = DBUtil.getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, id);

	        pstmt.executeUpdate();

	    } catch(Exception e) {
	        e.printStackTrace();
	    }		
	}	
	
} // end BannerDAO class
