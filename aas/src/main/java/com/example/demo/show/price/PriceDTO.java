package com.example.demo.show.price;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@Data
@ToString
public class PriceDTO {
    private int price_id;
	private String show_id;
	private String seat_level;
	private int price;
	private Integer add_p;
}
