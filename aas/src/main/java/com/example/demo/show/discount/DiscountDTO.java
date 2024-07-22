package com.example.demo.show.discount;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@Data
@ToString
public class DiscountDTO {
	private int dis_id;
    private String dis_name;
	private String dis_range;
	private int dis_rate;
	private String dis_info;
	private String dis_start;
	private String dis_end;
	private String dis_check;
	private String show_id;
}
