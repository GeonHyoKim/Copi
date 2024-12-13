package dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Message_1 {
	private int id;
	private int senderId;
	private int receiverId;
	private String content;
	private LocalDateTime timestamp;
	private boolean is_read;
	private String senderName;
    private String receiverName;
}
