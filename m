Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824AbbG3Jvj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 30 Jul 2015 05:51:39 -0400
Date: Thu, 30 Jul 2015 11:51:37 +0200
From: Karel Zak <kzak@redhat.com>
To: Reuti <reuti@staff.uni-marburg.de>
Cc: util-linux@vger.kernel.org
Subject: Re: hexdump: default output format is not -x
Message-ID: <20150730095137.GJ6865@ws.net.home>
References: <BC43BDB2-1CA2-4A85-A919-0C905AF00E41@staff.uni-marburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BC43BDB2-1CA2-4A85-A919-0C905AF00E41@staff.uni-marburg.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 29, 2015 at 04:54:38PM +0200, Reuti wrote:
> Although they are very alike, the different spacing can confuse
> users when reading the man page and trying to understand the
> different options. I suggest to either update the man page, or fix
> the source hexdump.c line 146, so that the default output is really
> -x or vice versa.
> 
> Personally I dislike the many spaces one gets with -x and would
> prefer the default format string also for -x.

 I also don't like the extra spaces, but I don't see another way how
 to resolve this problem than fix the man page. All another solutions
 will be backwardly incompatible.

 Fixed, thanks!

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
