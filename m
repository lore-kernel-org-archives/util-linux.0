Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:62753 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753306AbbKYDNA (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Nov 2015 22:13:00 -0500
To: util-linux <util-linux@vger.kernel.org>
From: Phillip Susi <psusi@ubuntu.com>
Subject: Can not move tmpfs mounts
Message-ID: <56552586.2040007@ubuntu.com>
Date: Tue, 24 Nov 2015 22:05:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

mount --move fails with -EINVAL on tmpfs mounts.  Is there some reason
for this, or is it a long standing kernel bug?

A bind mount followed by unmounting the original works, but seems like
this workaround should not be needed.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJWVSWDAAoJEBB5UWFcu6UWRJoH/RWUUbuLp0Jh54pXuRTaOp32
lTBNmFL3st9PVIWZw6vJmTWTekTDsqo/+BbqIxhq2Xm3BbuXMONuFRvp0ZeUAfmq
U2hjJzbIag+3TtxmULT5j5VuMHZUxzYjQDsTfSX/yyNrH9MjKt+MdxbvReYmesI4
ztozVmlM0ucgfIw27wY6jsgChFe/vAHAaIKL7FQ6Ya8pxPA00zRMAYJR/NegTwKD
yLW6mZnTJGtkIG3lC/8rOaqgYJStH3FU/1z390Fr0ZYWRMP2aMRHmMJWMx8lJ4+1
ZvFPS2T9Z3PnWTfrPMsbWzHJy3i8UaWItcRjpw27KKXmA1NMnQdL69+GDmJ4AnQ=
=wnEH
-----END PGP SIGNATURE-----
