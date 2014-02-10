Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:46714 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbaBJUsf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Feb 2014 15:48:35 -0500
Message-ID: <52F93B20.2030703@ubuntu.com>
Date: Mon, 10 Feb 2014 15:48:32 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: sfdisk does not handle whitespace the way the man page says
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Forwarding from deb bug #406817:

The sfdisk man page says:

Fields are separated by whitespace, or comma or semicolon possibly
followed by whitespace;  initial and  trailing  whitespace  is  ignored.

Looking at the code, it looks like it attempts to do this, but it
fails somehow.  It complains about trailing junk after number when I
give it:

"    2048,2048,80"

Further, it hard codes a single space or hard tab as a field separator
rather than using isspace() and does not make allowance for treating
multiple spaces as a single separator, nor ignoring white space after
a comma or semicolon.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJS+TsgAAoJEI5FoCIzSKrw6KYIAI82PcZHoJSOs5v1NOppGkbJ
jO5/+9xIFcwzFEXTA3b4772qiuKhV91C04dLt/n8uBwgI2kHT2jvdssqW/8g7UPs
HeHuCdmjdjmyEzRQmNhdODmRgulb6NyUxnQdxeDvPnc4cbV/n0hfzqL3vxx4Vlr4
GuzsCXk49P0TIfLaUsQicFuH8xxARcR64n14bZ97M049fTjIsZsDq2rsEWY7NEZy
ysADmMKoxlRD16gBFj0slvo9eOWPxR+e84wdbEEYohyM+Ej4+xebKqMbiwoBd+5x
CSA8eHpJnTftmjzk9AUPoAhM0m5HDECIQZSElF+M55iKLpN+3g2vp3pb4OnREh8=
=ZsOK
-----END PGP SIGNATURE-----
