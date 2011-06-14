Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:9311 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752553Ab1FNPRX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Jun 2011 11:17:23 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p5EFHMDv022353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 14 Jun 2011 11:17:22 -0400
Date: Tue, 14 Jun 2011 17:17:20 +0200
From: Karel Zak <kzak@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: Don't ignore swap UUID if only first byte is
	zero.
Message-ID: <20110614151720.GN14293@nb.net.home>
References: <20110613170541.GY28762@amd.home.annexia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110613170541.GY28762@amd.home.annexia.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 13, 2011 at 06:05:42PM +0100, Richard W.M. Jones wrote:
>  libblkid/src/superblocks/swap.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

 Applied, thanks.

> +		if (memcmp (hdr->uuid, zero_uuid, sizeof zero_uuid) != 0
> +		    && blkid_probe_set_uuid(pr, hdr->uuid) < 0)

 I have removed the memcmp(), it's already in blkid_probe_set_uuid().

       Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
