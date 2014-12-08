Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47421 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755040AbaLHLHz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Dec 2014 06:07:55 -0500
Date: Mon, 8 Dec 2014 12:07:44 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 02/10] cal: fix signed integer overflow [AddressSanitizer]
Message-ID: <20141208110744.GC19904@x2.net.home>
References: <1417355862-16935-1-git-send-email-kerolasa@iki.fi>
 <1417355862-16935-3-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417355862-16935-3-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 30, 2014 at 01:57:34PM +0000, Sami Kerola wrote:
>   November 2147483646   December 2147483646   January 2147483647 
>  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
> - 1  2  3  4  5  6  7   1  2  3  4  5  6  7   1  2  3  4  5  6  7 
> - 8  9 10 11 12 13 14   8  9 10 11 12 13 14   8  9 10 11 12 13 14 
> -15 16 17 18 19 20 21  15 16 17 18 19 20 21  15 16 17 18 19 20 21 
> -22 23 24 25 26 27 28  22 23 24 25 26 27 28  22 23 24 25 26 27 28 
> -29 30                 29 30 31              29 30 31

All months start at Sunday? Nice. 

It means that we had regression tests, but nobody reviewed that
the output from cal(1) in the tests makes any sense :-((((

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
