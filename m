Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:48720 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218AbaCZSrf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 26 Mar 2014 14:47:35 -0400
Message-ID: <533320C5.7040609@ubuntu.com>
Date: Wed, 26 Mar 2014 14:47:33 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: tty swtch key
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I could have sworn that I used the tty swtch feature once many years
ago and that it sent a special signal to the shell, causing it to be
suspended and return you to the parent shell, as if you had entered
the suspend command.  I can't find the signal in the man pages now,
and using stty to set a swtch key and hitting it does nothing.  Is
this unimplemented on linux, and if so, shouldn't the man page be
updated to reflect that?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTMyDFAAoJEI5FoCIzSKrw5/8IAIlrwdqcGiPX3uIjttm1E3sh
dltS5nUj9YP+blgsQ4h5uu8m/bzFGp19ocx7OlO3/1qESyuGpnwoNr9wJtzXB8YV
xqqbhlsIF+9dxdD9CUIcHkt+hb7Hu6WDh7YfJRfctfbQgYYVNYKbQgQrl9AMrNmK
DNtXJy90KUhpwqtR9RuOfbwcLsZUU4AsfyqujQs1zBbhAJm9i3JrUGewBUZ0QFOe
M2IW8619AW/qoI//ko1rNVkUBPraZAf4K/XeoQbmT87ch778E+EeWPZhClOlmbM2
QsynEnjy3uUj0r3A5ja97dphjeyGegHI7wpMVLnLs3iR9USOBrlwqll7b2IJYBw=
=DP1V
-----END PGP SIGNATURE-----
