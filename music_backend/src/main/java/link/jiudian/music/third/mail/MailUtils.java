package link.jiudian.music.third.mail;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Component
public class MailUtils {

    static Logger logger = LoggerFactory.getLogger(MailUtils.class);

    @Autowired
    private JavaMailSender javaMailSender;

    public void sendMessage(String email, String code) throws MessagingException {
        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper;
        helper = new MimeMessageHelper(message, true, "utf-8");
        helper.setFrom("service@jiudian.link");

        String[] mailList = {email,};
        helper.setTo(mailList);
        helper.setSubject("乐记邀请您注册");
        helper.setText("尊敬的乐记用户，您好:\n\t\t您的注册验证码是【" + code + "】5分钟内有效。" + "" +
                "\n\n\n乐记官方网站：https://music.jiudian.link/");

        javaMailSender.send(message);
        logger.info("send email: " + email + " " + code);
    }
}
