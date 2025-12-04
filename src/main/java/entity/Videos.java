package entity;

import jakarta.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity
@Table(name = "Video")
public class Videos {
	@Id
    @Column(name = "Id")
    private String id;

    @Column(name = "Titile")
    private String titile;

    @Column(name = "Poster")
    private String poster;

    @Column(name = "Views")
    private Integer views;

    @Column(name = "Description")
    private String description;

    @Column(name = "Active")
    private Boolean active;
    
    @Column(name = "Link")
    private String link;
}
