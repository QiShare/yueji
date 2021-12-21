package link.jiudian.music.security.jwt;

import io.jsonwebtoken.*;
import org.springframework.stereotype.Component;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class JwtTokenUtil implements Serializable {

    public static String generateJwtToken(String email) {
        Map claims = new HashMap();
        claims.put("email", email);

        try {
            String token = Jwts.builder()
                    .setClaims(claims)
                    .setExpiration(tomorrow(new Date()))
                    .signWith(SignatureAlgorithm.HS256, "test")
                    .compact();

            return token;
        } catch (Exception e) {
            return null;
        }
    }

    public static String parseJwtToken(String token) {
        Claims claims;
        try {
            claims = Jwts.parser().setSigningKey("test").parseClaimsJws(token).getBody();
            return (String) claims.get("email");
        } catch (ExpiredJwtException e) {
            return null;
        } catch (SignatureException e) {
            return null;
        } catch (Exception e) {
            return null;
        }
    }

    public static Date tomorrow(Date today) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(today);
        calendar.set(Calendar.DATE, calendar.get(Calendar.DATE) + 10);
        return calendar.getTime();
    }
}
