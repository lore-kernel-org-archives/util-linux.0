Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754859AbdKBJXh (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 2 Nov 2017 05:23:37 -0400
Date: Thu, 2 Nov 2017 10:23:32 +0100
From: Karel Zak <kzak@redhat.com>
To: Mikhail Vorobyov <m.vorobyov@cs.msu.ru>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: (sun) fix creation of whole disk partition
Message-ID: <20171102092332.wacgctcm7tw3wndo@ws.net.home>
References: <48789bdc-3354-5282-dbe8-fd81281324eb@cs.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48789bdc-3354-5282-dbe8-fd81281324eb@cs.msu.ru>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 02, 2017 at 04:04:42AM +0300, Mikhail Vorobyov wrote:
> sun_add_partition() allowed the 1st sector to be 0 for the 3rd partition
> only if that sector was free or if other partitions covered the whole
> disk. Now it's always allowed for the 1st sector to be set to 0 for
> the 3rd partition.

https://github.com/karelzak/util-linux/issues/505  Right?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
