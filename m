Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52015 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbbJLKAx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 Oct 2015 06:00:53 -0400
Date: Mon, 12 Oct 2015 12:00:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: Anthony DeRobertis <anthony@derobert.net>, 801527@bugs.debian.org,
        util-linux@vger.kernel.org
Subject: Re: Bug#801527: mount believes correctly-formatted UDF uid=forget
 option is in error
Message-ID: <20151012100049.GE2356@ws.net.home>
References: <20151011172712.28932.10676.reportbug@Watt.home>
 <20151011205848.GA16027@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151011205848.GA16027@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 11, 2015 at 10:58:48PM +0200, Andreas Henriksson wrote:
> Using LIBMOUNT_DEBUG=all mount -t udf -o uid=ignore,gid=forget ...
> shows the following message (among others):
> 
> 24171: libmount:    UTILS: cannot convert 'ignore' username to UID
> 
> ... and according to the following code you seem to be very right
> that except an actual uid you can also pass 'uid=ignore' or
> 'uid=forget' explicitly:
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/udf/super.c#n352
> 
> I see several possible options for implementing this in the future:
>  - special-case 'ignore' and 'forget' and pass those as is.
>  - if uid-lookup fails, try the above.
>  - (assuming different filesystems have different special options)
>    let any fs-option through as-is if 'smart lookup' fails.

This is the way how the original mount(8) has worked. Fixed:

 https://github.com/karelzak/util-linux/commit/440a355a3d3934d99f7ef82adf02342e6f2f7983

will be in v2.27.1.

Thanks!
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
