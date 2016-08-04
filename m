Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43968 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751030AbcHDKKY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 4 Aug 2016 06:10:24 -0400
Date: Thu, 4 Aug 2016 12:08:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/7] safe implementation of loop reuse
Message-ID: <20160804100849.opbsd4zdcjwywbx5@ws.net.home>
References: <ecb4b89d-f9ad-a854-80e5-c3fb49b200a2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ecb4b89d-f9ad-a854-80e5-c3fb49b200a2@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 14, 2016 at 03:28:11PM +0200, Stanislav Brabec wrote:
> That is why I wrote new implementation that should be safe.
> 
> To keep the code as small as possible, it changes API of several
> functions: it adds sizelimit check possibility.

Merged, I did some changes to the code. The most visible change is
that loopcxt_find_overlap() (originally loopcxt_check_conflict())
returns info about full match (offset and sizelimit matches). 

This allows to use just one iteration (loopdevs scan) in mount(8) to
check for overlaps as well as to found device to re-use.

All works as expected, but re-test if you can :-)

Tomorrow I'm going to work on the losetup patches.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
