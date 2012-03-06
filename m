Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38360 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751815Ab2CFMyr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 Mar 2012 07:54:47 -0500
Date: Tue, 6 Mar 2012 13:54:44 +0100
From: Karel Zak <kzak@redhat.com>
To: Frank Mayhar <fmayhar@google.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] fsck: Add a -r option to report memory and runtime
 statistics.
Message-ID: <20120306125444.GA8389@x2.net.home>
References: <1328649050.11787.28.camel@peace.lax.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328649050.11787.28.camel@peace.lax.corp.google.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 07, 2012 at 01:10:50PM -0800, Frank Mayhar wrote:
>  fsck/fsck.8 |   12 +++++++++++-
>  fsck/fsck.c |   38 +++++++++++++++++++++++++++++++++++++-
>  fsck/fsck.h |    2 ++
>  3 files changed, 50 insertions(+), 2 deletions(-)

 Finally I have time to work on fsck. I have created temporary branch
 at github for this task:

    https://github.com/karelzak/util-linux/commits/fsck

 changes:

  - fsck is only one fsck.c file, moved to disk-utils
  - use libmount to parse fstab and for is_mounted() function
  - does not use obsolete lib/fsprobe.c

> +\	/dev/hdc1 status 0 maxrss 92828
> +.br
> +\	/dev/hdc1 user 2.677592 system 0.861868 elapsed 4

 I have merged all to one line, final format is:

/dev/sda1: status 0, rss 92828, real 4.002804, user 2.677592, sys 0.86186

 The real/user/sys should be more compatible with time(1) now (so the
 'real' is based on gettimeofday() although it's not so important for
 fsck).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
