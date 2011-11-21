Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:56245 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751748Ab1KUULU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Nov 2011 15:11:20 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Subject: Re: flock in 2.20.1 can no longer lock the file it will execute
Date: Mon, 21 Nov 2011 15:11:19 -0500
Cc: util-linux@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        Petr Uzel <petr.uzel@suse.cz>
References: <201111140123.39789.vapier@gentoo.org> <201111161025.47605.vapier@gentoo.org> <20111121163543.GU7916@nb.net.home>
In-Reply-To: <20111121163543.GU7916@nb.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1667732.2jxNG0iEKK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201111211511.20270.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart1667732.2jxNG0iEKK
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Monday 21 November 2011 11:35:43 Karel Zak wrote:
>  Good idea, implemented and tested (git pull to get the change). It
>  seems it works with your example as well as with NFSv4.

latest git now works for my scripts too :)
-mike

--nextPart1667732.2jxNG0iEKK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOyrBoAAoJEEFjO5/oN/WBhIIQAMNFkk+k5LDqcPZOXBng2Bkd
W1nLwKrE2z0CSRanwSXG0d8cBmcrHmzZTGtGKlONkcfIiIKX+apk2A9oMwn8bI3V
L7X3geWihuKUjaxlit3cfuwK3aujqgUc/M8EqdaXHYTXl6UNfYpIrHhSfcFNz1nL
QXf++2B04VoBZ92OTAo75DuPhMk73Gx4iX8x1x9EQ/wIMDBU3cwyqQBG56Ke9jtj
kYB+zY+HaKLO8aWSAaEHc0MWY1CJISt7nP5k+Y0jb3zXruNIUp3VNU58N7QNrm5L
sPGMrbxhuny8417MhItybPZOcAHMnOiyJs6dqlU0b0JZk6cg8Oe8SuJmzOrpVbTM
N6zLYFRhQt9H0gMMlf32n/KylzgABQ7GLrrIoofwjGw1XhKMeEeW+L8vRlloW8EB
RP7YjcHpoGheIc+8KD4pJLCP1XRWnHeSzfZAqgQBV1y2h5qzNcZ9HaG3VyU6UNSH
xya+x9CSIUU2AzRKFPz9JkXnB9gj2e0W0cF3MwhMGWxuPu4xgLdrUPQeFd6efVa2
fD0bgqYi3mzsXBVEgY3P337vypcflOF25Md8ACVWZqIzEXBVTRgGmCh9xt3paPEV
+WskFwf0Fad4aah1y0owky9oO/2uHqTXBDQx7k/pSs4bxwxxBKlMug3bjNv2dokq
f5YziAGTy7OfRYg8xKhP
=qYLE
-----END PGP SIGNATURE-----

--nextPart1667732.2jxNG0iEKK--
