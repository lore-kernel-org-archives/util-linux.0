Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:65266 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753573Ab1GRJKW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Jul 2011 05:10:22 -0400
Date: Mon, 18 Jul 2011 11:10:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: add support for books
Message-ID: <20110718091017.GI3486@nb.net.home>
References: <20110705112909.GA3450@osiris.boeblingen.de.ibm.com> <20110711104035.GH5214@nb.net.home> <20110713034618.GA2968@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110713034618.GA2968@osiris.boeblingen.de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 13, 2011 at 09:16:18AM +0530, Heiko Carstens wrote:
> thanks. I updated the patch accordingly (see below).

 Applied, thanks.

> Just another thing: there are more per cpu informations that are present
> on s390 that I would also like to the parseable output. However, somehow
> it won't fit to the current approach that lscpu -p prints everything
> with a unique id starting from zero.
> For example the cpus on s390 can be in any of one of the states
> horizontal,vertical:low,vertical:medium or vertical:high (that's just
> an information of how the hypervisor schedules the cpus).
> How is that supposed to be mapped to current approach?
> Map these simply to numbers? E.g. horizontal would be mapped to 0,
> vertical:low would be mapped to 1 and so on?

 Probably, the most important is keep it backwardly compatible ;-)

> Also would I also need a new seperation character between caches and
> new information?

 I'm not sure if the currently used extra separators (,,) for the
 caches is a good idea. Maybe it would be better to force people to
 parse the last comment line where is the header for the columns.

> I'm asking because the output of caches is optional and if something
> new would be added, it seem to get messy in the long term because of
> all seperation characters that may or may not be there. No?

 I agree. Maybe you can add the new things before the caches (as you
 already added 'Book' column).

 The ideal solution is to extend the "-p" functionality and allow to 
 specify expected columns at command line, something like:

    lscpu -p -o cpu,core,book,socket

 We already use the same idea for findmnt and lscpu.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
