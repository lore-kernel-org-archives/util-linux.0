Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932303AbaJXLIK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Oct 2014 07:08:10 -0400
Date: Fri, 24 Oct 2014 13:08:03 +0200
From: Karel Zak <kzak@redhat.com>
To: JWP <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] hwclock: clean up messages
Message-ID: <20141024110803.GB10134@x2.net.home>
References: <5449BD0F.2070906@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5449BD0F.2070906@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 23, 2014 at 10:44:31PM -0400, JWP wrote:
> This patch set cleans up various message output.
> It contains cosmetic changes only.
> 
> J William Piggott (5):
>   hwclock: Remove newline from 'date' debug output
>   hwclock: clean up message periods/full stops
>   hwclock: add message line breaks
>   hwclock: Fix --date debug messages
>   hwclock: version prints out of order

I'm going to merge these patches, but as a long term solution it would
better to use include/debug.h stuff (see for example
misc-utils/whereis.c or libmount/src/init.c).

The debug.h provides more elegant way for debug messages. It's
possible to define mask to specify wanted messages and all is
controlled by <NAME>_DEBUG= env. variable etc. 

It's probably too verbose for hwclock --debug, but let's ignore this
problem for now. I'll make the output more user friendly ASAP.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
