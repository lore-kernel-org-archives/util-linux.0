Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:23282 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753076Ab1JKJe5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Oct 2011 05:34:57 -0400
Date: Tue, 11 Oct 2011 11:34:53 +0200
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org, Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH 2/2] mountpoint: support symbolic and relative paths
Message-ID: <20111011093453.GK11730@nb.net.home>
References: <1318288456-22940-1-git-send-email-dreisner@archlinux.org> <1318288456-22940-2-git-send-email-dreisner@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318288456-22940-2-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 10, 2011 at 07:14:16PM -0400, Dave Reisner wrote:
> Use our own canonicalize library to resolve a provided path before
> checking if its a mountpoint.

 Good idea. Thanks.

 I have applied a more robust solution based on libmount.

    Karel


==27191== Command:
/home/projects/util-linux/util-linux/sys-utils/.libs/mountpoint home
==27191== 
home is a mountpoint
==27191== 
==27191== HEAP SUMMARY:
==27191==     in use at exit: 0 bytes in 0 blocks
==27191==   total heap usage: 535 allocs, 535 frees, 44,094 bytes
allocated
==27191== 
==27191== All heap blocks were freed -- no leaks are possible
==27191== 
==27191== For counts of detected and suppressed errors, rerun with: -v
==27191== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 6 from 6)

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
