package net.koreate.cinema.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import net.koreate.cinema.services.BannerService;
import net.koreate.cinema.vo.BannerVO;

@Controller
@RequestMapping("/banner")
public class BannerController {

    private BannerService service = new BannerService();

    @GetMapping("/list")
    @ResponseBody
    public List<BannerVO> list() {
        return service.selectList();
    }
    
    // insert 기능
    @PostMapping("/insert")
    @ResponseBody
    public String insert(BannerVO vo){
        service.insert(vo);
        return "success";
    }
    
    // update 기능
    @PostMapping("/update")
    @ResponseBody
    public String update(BannerVO vo){
    	
        if(vo.getId() == null){
            System.out.println("❌ 잘못된 요청 차단: " + vo);
            return "fail";
        }

        System.out.println("정상 요청: " + vo);
                     
        service.update(vo);
        return "ok";
    }
    
    @PostMapping("/upload")
    @ResponseBody
    public String upload(HttpServletRequest request,
    					 @RequestParam("file") MultipartFile file){
        // 파일 저장
        try {
        	String fileName = file.getOriginalFilename();
        	
        	// 1) 톰캣 경로
        	String path = request.getServletContext()
        			.getRealPath("/resources/img/banner/");
        	
        	File dir = new File(path);
            if(!dir.exists()){
                dir.mkdirs();
            }
        	
            File dest1 = new File(path, fileName);
            file.transferTo(dest1);
            
            // 2️) Git 경로 ⭐
            String gitPath = "C:/Users/KTE/git/final_project/src/main/webapp/resources/img/banner/";
            
            // 다른 컴일 시
//            String gitPath = new File("src/main/webapp/resources/img/banner/")
//                    .getAbsolutePath() + "/";
            
            File dir2 = new File(gitPath);
            if(!dir2.exists()){
                dir2.mkdirs();
            }

            File dest2 = new File(gitPath, fileName);

            // ⭐ 복사 (핵심)
            Files.copy(dest1.toPath(), dest2.toPath(), StandardCopyOption.REPLACE_EXISTING);
            
            // 3) DB 처리
            service.resetActive();
            
            BannerVO vo = new BannerVO();
            vo.setImgName(fileName);
            vo.setIsActive("Y");

            service.insert(vo);
            
		} catch (Exception e) {
	        e.printStackTrace();
	        return "fail";
		}

        return "ok";
    }    
    
	// delete 기능
	@PostMapping("/delete")
	@ResponseBody
	public String delete(int id){
	    service.delete(id);
	    return "ok";
	}	  
    
}