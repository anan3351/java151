package com.example.demo.show.price;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@NoArgsConstructor
@Data
@ToString
public class PriceDTO {
    private String price_id;
	private String show_id;
	private String seat_level;
	private String price;
	private String add_p;
}
