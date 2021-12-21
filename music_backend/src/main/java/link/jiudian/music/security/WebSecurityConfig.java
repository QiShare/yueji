package link.jiudian.music.security;

import link.jiudian.music.security.email.EmailAuthenticationFailureHandler;
import link.jiudian.music.security.email.EmailAuthenticationProvider;
import link.jiudian.music.security.email.EmailAuthenticationSuccessHandler;
import link.jiudian.music.security.email.EmailLoginProcessFilter;
import link.jiudian.music.security.jwt.JwtAuthenticationEntryPoint;
import link.jiudian.music.security.jwt.JwtAuthenticationProvider;
import link.jiudian.music.security.jwt.JwtAuthenticationTokenFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private EmailAuthenticationProvider emailAuthenticationProvider;

    @Autowired
    private JwtAuthenticationProvider jwtAuthenticationProvider;

    @Autowired
    private JwtAuthenticationEntryPoint unauthorizedHandler;

    @Autowired
    private EmailAuthenticationFailureHandler failureHandler;

    @Autowired
    private EmailAuthenticationSuccessHandler successHandler;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(emailAuthenticationProvider);
        auth.authenticationProvider(jwtAuthenticationProvider);
    }

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    public JwtAuthenticationTokenFilter authenticationTokenFilterBean() throws Exception {
        return new JwtAuthenticationTokenFilter();
    }

    public EmailLoginProcessFilter smsLoginProcessFilter() {
        EmailLoginProcessFilter smsLoginProcessFilter = new EmailLoginProcessFilter("/auth/login", successHandler, failureHandler);
        smsLoginProcessFilter.setAuthenticationManager(authenticationManager);
        return smsLoginProcessFilter;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable()
                .exceptionHandling().authenticationEntryPoint(unauthorizedHandler)
                .and()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .authorizeRequests()
                .antMatchers("/feedback/**")
                .permitAll()
                .antMatchers("/check/update/**")
                .permitAll()
                .antMatchers("/download/android/**")
                .permitAll()
                .antMatchers("/home/**")
                .permitAll()
                .antMatchers("/article/**")
                .permitAll()
                .antMatchers("/auth/**")
                .permitAll()
                .anyRequest()
                .authenticated();

        http.addFilterBefore(smsLoginProcessFilter(), UsernamePasswordAuthenticationFilter.class)
                .addFilterBefore(authenticationTokenFilterBean(), UsernamePasswordAuthenticationFilter.class);
    }
}
