Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35103 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457Ab1HVN2V (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Aug 2011 09:28:21 -0400
Date: Mon, 22 Aug 2011 15:28:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] new chcpu tool
Message-ID: <20110822132817.GD20457@nb.net.home>
References: <20110815152453.052584040@de.ibm.com> <20110822120641.GA7549@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110822120641.GA7549@osiris.boeblingen.de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 22, 2011 at 02:06:41PM +0200, Heiko Carstens wrote:
> Do you think it would be ok to have it in util-linux? Or should it live
> somewhere else?

It makes sense to have it in util-linux. I'm going to merge it after
v2.20 release.

> Another reason for trying to add it to util-linux is that we want to avoid
> doing the same mistake we did already with the "lsmem" and "chmem" tools
> which can configure hotplug memory. These tools are completely architecture
> independent, but we put them into our "s390-tools" package.
> I think both of them should live in util-linux instead... But that's
> something we could address later anyway :)

 OK :-)

> +static int path_exist(const char *path, ...)

 It seems that we need to move the path_*() functions from lscpu(1) to
 lib/ and hare the stuff.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
