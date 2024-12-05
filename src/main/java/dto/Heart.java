package dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Heart {
	private Integer id;
	private Integer senderId;
	private Integer receiverId;
	private Integer point;
}
