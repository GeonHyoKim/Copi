package dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Gift {
	private int id;
	private String giftName;
	private int price;
	private GiftPic giftPic;
}
