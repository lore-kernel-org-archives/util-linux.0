Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19275 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751836AbaF0Hl4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Jun 2014 03:41:56 -0400
Date: Fri, 27 Jun 2014 09:41:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Eric Rannaud <e@nanocritical.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <d@falconindy.com>
Subject: Re: [PATCH 4/4] findmnt: use mnt_cache_set_targets() for non-kernel
 table
Message-ID: <20140627074149.GC750@x2.net.home>
References: <747e9f8de90dc1e906d2f84f3952a801e70ef3d0.1403845374.git.e@nanocritical.com>
 <7f69c8fad1eed4faee033f1164f7481b10593413.1403845374.git.e@nanocritical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7f69c8fad1eed4faee033f1164f7481b10593413.1403845374.git.e@nanocritical.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 26, 2014 at 10:18:48PM -0700, Eric Rannaud wrote:

> * This was tested on a system with a stale mount under /mnt: findmnt -s /usr
>   With 2.24.2, strace shows a lstat("/mnt") (and hangs), but no lstat on active
>   mount points with this change (and doesn't hang).
> 
> * mountinfo is read whenever the main table is not from the kernel (tabtype !=
>   TABTYPE_KERNEL), with or without -T. I can't think of a reason to only do
>   this when -T is specified.

 Yep, it seems fine.

> * Karel, you mentionned this would have a performance impact on large systems,
>   but I do not know how to asses it. Should there an option to turn this new
>   behavior on or off?

 I have talked about your original idea to parse mtab always in
 canonicalize_path() when someone asking for any path canonicalization. The 
 solution with the cache is better because we parse the file only once.

> * Should --nocanonicalize be removed after this patch?

 I think it makes sense to keep it there, at least for testing we have
 a way how to turn all the cache stuff off. We have the same option
 for mount(8) just for cases when you can be sure that all is already
 canonical.


 Good work, the patches look good, I'll merge it next week. I'll try
 to use it also for mnt_context_* function in libmount, maybe we can
 avoid unnecessary canonicalization in mount/umount too. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
