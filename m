Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:57406 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbaA2PEm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 29 Jan 2014 10:04:42 -0500
Message-ID: <52E91888.4080601@ubuntu.com>
Date: Wed, 29 Jan 2014 10:04:40 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: pivot_root depreciated?
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I could have sworn that the pivot_root syscall was considered a
fragile dirty hack that needed to die in a fire, and everyone switched
to run-init years ago.  Am I misremembering things or does anyone know
what I'm talking about?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJS6RiIAAoJEI5FoCIzSKrwvW0IAJtdki3mJn6AqiRQdxcDA4Km
Wbxk/YAuotL/RD4JHASs5ewlRD8FJDHK5zm38b5Gp6h1QRAtmWYFgX3v2QDzsnK9
gkurBVNNYKklARBo4yKoGbbzIPfnpeIP1bgKblPc1/bLjt9/d9bJY0NQ8MsuhR1+
HmGTB5WiIidQ5n8A9x3IgySBmrqTikiVEwk4SshJtbfWGGd2WT4kzNlYKbvAyxFm
Pok+f88+f/Zj5toajVtnbE2QOIMn2LSJYZeecodWa/Eq787OK9hAt2lnJSexFSV3
wfWVxrtEbQtjoqSYXixbu0OnuJ8InEcWEObALiEa5069JmTOi8i/njE7M9sBef4=
=O5GB
-----END PGP SIGNATURE-----
