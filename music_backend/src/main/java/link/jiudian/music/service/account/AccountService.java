package link.jiudian.music.service.account;

import link.jiudian.music.model.Account;
import link.jiudian.music.repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class AccountService {

    @Autowired
    private AccountRepository accountRepository;


    public Account insertAccount(AccountBO accountBO) {

        Account account = new Account();
        account.setEmail(accountBO.getEmail());
        account.setCreateTime(new Date());

        return accountRepository.save(account);
    }

    public Account getAccount(String email) {
        Account account = accountRepository.findByEmail(email);
        return account;
    }

    public Account getAccountById(long id) {
        Account account = accountRepository.findById(id).get();
        return account;
    }


    public void updateAccount(Account account) {
        accountRepository.save(account);
    }

}
