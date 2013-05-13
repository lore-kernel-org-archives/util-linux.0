Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40269 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336Ab3EMJHd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 May 2013 05:07:33 -0400
Date: Mon, 13 May 2013 11:07:28 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Jeff Mahoney <jeffm@suse.com>
Subject: Re: loopdev regression with v2.23
Message-ID: <20130513090728.GB26163@x2.net.home>
References: <20130511233910.GO494@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130511233910.GO494@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, May 11, 2013 at 07:39:10PM -0400, Dave Reisner wrote:
> I have a bug report that points out that v2.23 has disallowed losetup of
> a block device with an offset:
> 
> https://bugs.archlinux.org/task/35193
> 
> As I also note in the bug report, I've bisected this to commit 293714c0d15.
> 
> I'm not clear on what the proper fix is here -- "expected_size" is set
> to 0 since the fstat call is performed on a special file which has a 0
> size. Is the right thing to do simply return 0 if the size of the
> "backing file" is 0?

The right thing is to use size of the block device if the backing file
is a block device. Fixed. Git pull.

All this is workaround for kernel bug (already fixed in v3.9). I hope
that one day we will use KERNEL_VERSION macro to exclude all this
painful thing :-)

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
