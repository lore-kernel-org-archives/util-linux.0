Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:57566 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbaANPV2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 14 Jan 2014 10:21:28 -0500
Message-ID: <52D555F7.7020405@ubuntu.com>
Date: Tue, 14 Jan 2014 10:21:27 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Scott Moser <smoser@ubuntu.com>
CC: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] fix partx --update ranges and out of order tables
References: <alpine.DEB.2.02.1401131526340.5329@brickies> <20140114085439.GF12700@x2.net.home> <52D54D09.10506@ubuntu.com> <alpine.DEB.2.02.1401140952480.5329@brickies>
In-Reply-To: <alpine.DEB.2.02.1401140952480.5329@brickies>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/14/2014 9:53 AM, Scott Moser wrote:
> I figured I'd leave that up to upstream. I had an implementation of
> that, but didn't know of the policy for adding stuff to libblkid.
> This was less invasive.  I'm fine with libblkid also.

Right, that was directed at Karel ;)


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJS1VX3AAoJEI5FoCIzSKrw2poIAJlwO24I6M6I+8RGMx3DGzNv
8/dX2CyIQQ59AXoCEIs/t6nY/LO+CuSn1h/xZx+zdDrp4/apSEHl058kBAFhfb3U
4YTtlFgvdJOuWLrXYAMTBYNLS6SsMNEiIipsdomFSRMhufgE12jx/HXcp7sZw75Q
7D0k9kGZfw376RE8R4OveOsU9cpIbhgP509rCXNF5En+lil0npOV18YshaI2FapE
d1hUaKrio16YKKLlxMNEX+aUWBLgkBLapohRZBv1ce4NeMPoSRBshq4fEMA5K5ou
Lw30+oVCynwKCqFqAqKH5Lx6vKgIZIr78j6+5rD+U0LoZkq/fklUEfn2BGnRh2k=
=vgEx
-----END PGP SIGNATURE-----
