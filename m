Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48023 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757572Ab3KNWV1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Nov 2013 17:21:27 -0500
Date: Thu, 14 Nov 2013 23:21:21 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fdisk expert print lists wrong start sector for logical
 partitions
Message-ID: <20131114222121.GG13330@x2.net.home>
References: <5283A380.6020909@ubuntu.com>
 <20131114115711.GE13330@x2.net.home>
 <5284F93F.8020601@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5284F93F.8020601@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 14, 2013 at 11:24:31AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/14/2013 6:57 AM, Karel Zak wrote:
> > It's correct, although probably it seems strange at a first
> > glance.
> > 
> > It dumps MBR and EBR tables, nothing else. It means that you can 
> > see all the values as stored on the device without any
> > calculation.
> 
> So it isn't saying the partition starts at sector 2048, but rather it
> is 2048 sectors from the EBR?

 Yep.
    Karel

> 
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.17 (MingW32)
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
> 
> iQEcBAEBAgAGBQJShPk+AAoJEJrBOlT6nu75oUIH/iuXeQO+m9zuazRX26qJFMmY
> OtdPbSX73qEoP+/nB/aKFJH8w20Mlx6z5t9jX6yaZedYkDMXsup8rOzG9nQh854U
> ZRGhqfoA5gTfLUqZqAyzyaNT6tCxDIX8IBtC7eLKsz21SwlAWtxiVndS5eQ0ySc3
> moW4igUcg5zgwc6JJc5Ybx38T4kT4McBZpJAh3mMhFPww20o8WS3vmAnCYTZi9jt
> H3HvR9OBKKEZxmz/Ddlz3YcQ6U5Z941xns/MbxAJMCl8ZY9Fn7dByvCEyuBtQ2Rs
> wGz+XQJ1s/fEMDVko6xgEGmiSyQoVe76ux9iHe4u4Z22h+cbbH7AxpYmPhSUfJM=
> =YrnF
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
