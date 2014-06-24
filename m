Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53141 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026AbaFXI4P (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jun 2014 04:56:15 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5O8uFUp008600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 24 Jun 2014 04:56:15 -0400
Date: Tue, 24 Jun 2014 10:56:12 +0200
From: Karel Zak <kzak@redhat.com>
To: David Shea <dshea@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Correct the return values in squashfs probe
Message-ID: <20140624085612.GB13203@x2.net.home>
References: <1403545308-18371-1-git-send-email-dshea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403545308-18371-1-git-send-email-dshea@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 23, 2014 at 01:41:48PM -0400, David Shea wrote:
>  libblkid/src/superblocks/squashfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

 Applied, thanks.

>  	sq = blkid_probe_get_sb(pr, mag, struct sqsh_super_block);
>  	if (!sq)
> -		return -1;
> +		return 1;

 Note that the current libblkid code is sensitive to IO errors, so the
 correct changes is

        return errno ? -errno : 1;


  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
