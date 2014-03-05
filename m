Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41765 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568AbaCEL1K (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 5 Mar 2014 06:27:10 -0500
Date: Wed, 5 Mar 2014 12:27:04 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] libmount: define BTRFS_TEST_MAGIC if missing
Message-ID: <20140305112704.GE13353@x2.net.home>
References: <531702A6.2070903@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <531702A6.2070903@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 05, 2014 at 11:55:34AM +0100, Bernhard Voelker wrote:
> * libmount/src/utils.c (BTRFS_TEST_MAGIC): Conditionally add define
> which is used since commit v2.24-243-g6a52473.

 Applied, thanks.

 Unfortunately, this is not end of the statfs f_type horror -- all
 depends on kernel headers version, stuff in linux/magic.h, etc. And
 the list of the filesystems is also not complete.
 
 So I guess we will see more reports...

 Maybe the best would be to create our private include/statfs_magic.h
 with ifndef-define for all filesystems.

 I'm trying to cleanup this thing in kernel tree, but the result is 
 doubtful

  http://www.spinics.net/lists/linux-fsdevel/threads.html#73297
 
 and we still need compatibility with already released kernels.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
