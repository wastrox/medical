emails_duplicate = []
accounts = Account.all
accounts.each{ |a| emails_duplicate << a.email.downcase }

emails_duplicate.detect{ |e| emails_duplicate.count(e) > 1 }

