Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:34684 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab3KGRDE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Nov 2013 12:03:04 -0500
Message-ID: <527BC7C5.8010700@ubuntu.com>
Date: Thu, 07 Nov 2013 12:03:01 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Simple blkid typeo
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

- --- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -595,7 +595,7 @@
        return mask;
 err:
        *flag = 0;
- -       fprintf(stderr, "unknown kerword in -u <list> argument: '%s'\n",
+       fprintf(stderr, "unknown keyword in -u <list> argument: '%s'\n",
                        word ? word : list);
        exit(BLKID_EXIT_OTHER);
 }
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSe8fFAAoJEJrBOlT6nu75L3QIAJmMW9/m7d4aQ1ty7ccIUhZz
4B25djaB+3rDckHUgOAKK8z1/cjR9SkGvKZHDaiIAtwCfCaMZa+2Oiw3O69wcZt1
G+ZA2W5pJ8azO6KUiP2m2+9i8RrBr8ld772kviZNVI8BuXJvPTizHPu+YzO/C8Wl
i5GAAlgJaGlGc2K8LDAvM4azF8mWwQEvJB9Pg7xA4xt1s6OxUTKFDV24xvWadYRF
jrMHa7dWYPCLt4S6nG+CTwde99S099A85MjEzFWZsrCyhB7NoWDAVBD9KqVHaSwP
u58lVj/tre2aRaPaa5fWgmnCi3J5eEWjpIdWkUTU+GUj0awcMszpamWbtIFiNXk=
=gp0j
-----END PGP SIGNATURE-----
