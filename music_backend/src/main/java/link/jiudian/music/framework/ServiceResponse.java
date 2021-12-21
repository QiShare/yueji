package link.jiudian.music.framework;

import lombok.Data;

import java.io.Serializable;

@Data
public class ServiceResponse implements Serializable {
    private int code;
    private String msg = "success";
}
