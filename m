Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:41474 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab3J3PQA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 30 Oct 2013 11:16:00 -0400
Message-ID: <527122AF.90003@ubuntu.com>
Date: Wed, 30 Oct 2013 11:15:59 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Bind mounts record fstype of none
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I came across an old bug filed in debian noting that mount records the
fstype for bind mounts as 'none' and this causes df to suppress
showing it.  This seems like an error to me.  The type should be what
the actual filesystem type is, and if df wants to suppress showing
bind mounts, it should do so based on the bind flag.

Thoughts?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJScSKuAAoJEJrBOlT6nu75tJwIAKk1IQyvsQIpPUj9ugSrHVDp
CdsGB5D8VNznUJ+a+AReNp57AGi/UprdCXsWl33yOuz3zjQKNlYaGEMCsN/pSJnq
nn+8pJ5GSggPekUh2FO82sLGaEh4y+rMPlN6rwCyOERkP1V+MaYI9Z2KzCrpnpfI
LaDm17q1IzpDtJry55Vg+yd0vuJZ3qpfvLUmD4rj/h7N5gt/lXWeSzcUyIIQvHaA
IR7Nch1YaA612Tqz0Zf+dews1ERwERNw2+s8BBlsvTW4FzbR5gfMdn3Xzv8WFnTY
yr54S7Krrxn7jbBFCF44GQddxptIJ7jjI2GqYIq1D8L9DoTwSIGEk552/y2negc=
=k4dY
-----END PGP SIGNATURE-----
