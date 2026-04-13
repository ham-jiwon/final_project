package net.koreate.cinema.vo;

import lombok.Data;

@Data
public class BannerVO {
    private Integer id;
    private String imgName;
    private String isActive;
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getIsActive() {
        return isActive;
    }

    public void setIsActive(String isActive) {
        this.isActive = isActive;
    }    
}
