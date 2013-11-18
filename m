Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:38957 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab3KRUGw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Nov 2013 15:06:52 -0500
Message-ID: <528A735A.9060606@ubuntu.com>
Date: Mon, 18 Nov 2013 15:06:50 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: umount by uuid
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

It seems that you now can umount by uuid using the UUID= tag, but not
with the -U switch, so it doesn't mirror mount.  Should this be added,
or is the -U form considered depreciated?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSinNaAAoJEJrBOlT6nu75koQH/3oHJy6CWkF96MdSNfIS7prn
R4Cz+F9NTSXagcVAzvUzgb2+yZ1QlMywyEQc+iX6oajB7+OFTJVY5E5et+zgGqOa
tPkz97iuPrq1yM3L8F9+aHtyUX79BFjoJtZm4gbbu1AcOrum+AQCo/YPpOZSnawH
s5GcHv75oUUeKHKyni1vbRtd2TKi94GV6gVzmXlm8SIpDjmuRfPjvvFFrId7wMnj
0DuWBFgM1/XW2snU+dt7E/QhUFnFwTYN0Up8+v0vn6iH6xpSspomBgzF7sHOAiu3
tH8UEtcg7qiFrsM9R2oF6Wua6u3yOUYZhQwOU6xXT5pF4T5cpaqKzB/cPQH8n3k=
=LQnd
-----END PGP SIGNATURE-----
