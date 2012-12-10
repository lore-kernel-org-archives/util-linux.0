Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52697 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808Ab2LJIm4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Dec 2012 03:42:56 -0500
Date: Mon, 10 Dec 2012 09:42:50 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: blkid: exit code as non-root user, and segfault
Message-ID: <20121210084250.GA21405@x2.net.home>
References: <50C4CFDD.1070405@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50C4CFDD.1070405@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 09, 2012 at 06:52:29PM +0100, Bernhard Voelker wrote:
> blkid returns 0 without output when running as non-root user
> and when the cache /dev/.blkid.tab is not yet there:
> 
>   ./blkid /dev/sdb3 ; echo $?
>   0

./blkid /dev/sdb3; echo $?2
2

> And another issue: blkid segfaults with this - okay, bad use of options:
> 
>   ./blkid -n /dev/sdb3
>   Segmentation fault

 Fixed by:

 commit 2e31fe2303e4938ef735aebf13aa5b22fb031af9
 Author: Karel Zak <kzak@redhat.com>
 Date:   Tue Dec 4 11:58:13 2012 +0100

     libblkid: cleanup nonnull attribute usage


> Using latest git; it doesn't dump core with 2.20.1.

 Really latest? ;-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
