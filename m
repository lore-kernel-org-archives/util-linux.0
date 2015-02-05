Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f50.google.com ([209.85.216.50]:46724 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbbBET7u (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 5 Feb 2015 14:59:50 -0500
Received: by mail-qa0-f50.google.com with SMTP id k15so7498981qaq.9
        for <util-linux@vger.kernel.org>; Thu, 05 Feb 2015 11:59:49 -0800 (PST)
Message-ID: <54D3CBAE.2000402@ubuntu.com>
Date: Thu, 05 Feb 2015 14:59:42 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: cfdisk will happily create a partition of size zero
References: <1422698319.1391339.221285309.35047434@webmail.messagingengine.com>
In-Reply-To: <1422698319.1391339.221285309.35047434@webmail.messagingengine.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/31/2015 4:58 AM, Benno Schulenberg wrote:
> /dev/sda4               93755392  312581807  218826416  104.4G   5
> Extended |-/dev/sda5             93757440   93757440          0
> 0B  83 Linux `-Free space            93759488  312581807  218822320
> 104.4G
> 
> Strange.  Start and end of sda5 are on the same sector?

Looks like there is also an off by one error in the size calculation
since a partition that starts and ends on the same sector does still
occupy that one sector, so its size can not be zero.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJU08uuAAoJENRVrw2cjl5RBSEIAJ9h1JTD0rVEx+/veyLN+Rz1
ZfjWQI2hQBgxszdFv1ZxQlJRT9xWOgjru2Cn/n/XGBqhXzRc3naUjKvsTlemNKlQ
d+8hgBv/3dxe80+Wh1BbVAfhjVggmMI+ak5ABlAuKwQm+VD8X2dXA7CpC0o3+9Iu
kRyVtp1tTKHZSOW7SV9kFk/yCgurmA4kskxyfG3RpjPD6+STRsAm2f//m1H3nfdP
ele1aDnvPtb6z85XDAeFNXWY++5Bhk7swgNO+Ad/jmEIaej4kxjItRti0jEjIMK+
nOZ6m/lK4+ATeVwku2aJ7GxPd1YPmhu4MgllDLoelDRBMESC4fh/iCWtND8Vr2A=
=Llf2
-----END PGP SIGNATURE-----
