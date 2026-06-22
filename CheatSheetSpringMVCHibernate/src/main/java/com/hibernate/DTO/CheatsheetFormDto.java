package com.hibernate.DTO;

import lombok.Data;

@Data
public class CheatsheetFormDto {
    private String title;
    private String description;
    private String visibility; 
    private Long categoryId;   
    private String themeColor; 
    
}