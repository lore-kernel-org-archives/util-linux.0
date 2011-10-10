Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:15154 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702Ab1JJXGC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Oct 2011 19:06:02 -0400
Date: Tue, 11 Oct 2011 01:05:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Dave Reisner <d@falconindy.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] mountpoint: refactor exit path
Message-ID: <20111010230558.GA12009@nb.net.home>
References: <1318173125-16156-1-git-send-email-dreisner@archlinux.org> <20111010194545.GB8822@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111010194545.GB8822@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 10, 2011 at 03:45:45PM -0400, Dave Reisner wrote:
> On Sun, Oct 09, 2011 at 11:12:04AM -0400, Dave Reisner wrote:
> > There's only one condition for which we declare success, but many for
> > failure. Initialize rc as failure and set to success on this single
> > condition. In all cases, jump to a label to exit instead of exiting
> > immediately. This will be used later on to ease cleanup of any heap
> > allocations.

 Well, free() before exit() is usually waste of time... but maybe we
 can think about mountpoint(1) as about libmount test application,
 then it would be nice to keep it without leaks (for example for
 valgrind).

> @Karel: I can resend this if you like.

 go ahead, thanks


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
