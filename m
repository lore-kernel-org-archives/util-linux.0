Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57269 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752553AbbG0Nvt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Jul 2015 09:51:49 -0400
Date: Mon, 27 Jul 2015 15:51:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: cfdisk: partition type wraps to next line on small screens
Message-ID: <20150727135146.GF6865@ws.net.home>
References: <1437837442.451484.332903777.1A436FE4@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437837442.451484.332903777.1A436FE4@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jul 25, 2015 at 05:17:22PM +0200, Benno Schulenberg wrote:
> Do for example:
> 
> stty cols 64
> ./cfdisk
> 
> Press <Down> several times; then <Up> several times.
> See how fragments of the partition type remain at the
> start of each line.

Fixed.
 
> Something else.  The extra info block contains two lines
> giving the Start C/H/S and End C/H/S.  But on my system
> all of them say "1023/63/254" (except for the first
> partition), so that seems to me pointless information.
> Maybe show them only when the Start and End values differ?

I have remove both CHS at all. It does not provides any useful
information.

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
