Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:54439 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbaAJOiV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 10 Jan 2014 09:38:21 -0500
Message-ID: <52D005DC.1000809@ubuntu.com>
Date: Fri, 10 Jan 2014 09:38:20 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Another question on bind mounts without mtab
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've had another question come up about bind mounts and the lack of
mtab and I'm not sure how to answer it because it does seem a more
important use case that has been lost than those previously discussed.

If /dev/sda1 is mounted in /, and you bind mount /home/foo to /mnt,
then there is no way to tell from the output of mount that it is in
fact, the /home/foo directory of /dev/sda1 that is in /mnt.  It looks
like you just bind mounted the whole drive there, and the subdirectory
path is lost.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJS0AXcAAoJEI5FoCIzSKrw/H4H/0tHL4gj0O7Ftj/wC02hRnP2
jz5cSaHntsQPyu4qZ7YAda4D0niuF+dRO/OXOak6QkJS1FgmXVWrKvfgfe+diut9
YcxzQkc8P/uDxpC08Hh00JIy7GN0oSGiITQp7VLBd6c96tdT7rQC8AgymaSnBwfT
BDA65x7StqFcWi46l9Te9CG48ZV0XtVGx+IsaV6RR78yO1XLG3cQ/CCV4PNE04zr
DcsfA1fhVfTkiRWEp4AxjrDuciLe8NSXk5mUd1GuL3I9CmrLJIkMZ7DMu1ucAiSQ
Q0u/KSfvfpT211TwDfCfk9Bc+uPfnfxrrLWYwejU0uJI/qJIC/DuX314mIEr6n4=
=d4lU
-----END PGP SIGNATURE-----
