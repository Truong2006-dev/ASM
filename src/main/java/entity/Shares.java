package entity;

import java.util.Date;
import jakarta.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity
@Table(name = "Share")
public class Shares {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "UserId")
    private User user;

    @ManyToOne
    @JoinColumn(name = "VideoId")
    private Videos video;

    @Column(name = "Emails")
    private String emails;

    @Temporal(TemporalType.DATE)
    @Column(name = "ShareDate")
    private Date shareDate;
}
