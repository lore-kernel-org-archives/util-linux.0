Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53181 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111AbcCJOYx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Mar 2016 09:24:53 -0500
Date: Thu, 10 Mar 2016 15:24:50 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: =?iso-8859-1?Q?R=FCdiger?= Meier <sweet_f_a@gmx.de>,
        util-linux@vger.kernel.org
Subject: Re: sfdisk, stderr/stdout output order
Message-ID: <20160310142450.rqx2yfah5waotnag@ws.net.home>
References: <201603101140.50532.sweet_f_a@gmx.de>
 <20160310111605.n2jona662wvbgymh@ws.net.home>
 <56E17FDC.6010604@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <56E17FDC.6010604@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 10, 2016 at 03:08:28PM +0100, Bernhard Voelker wrote:
> On 03/10/2016 12:16 PM, Karel Zak wrote:
> >On Thu, Mar 10, 2016 at 11:40:50AM +0100, Rüdiger Meier wrote:
> >>I've found such test diffs with musl libc. Maybe it needs some fflush(3)
> >>calls.
> >
> >  Yes, good point. I'll fix it.
> 
> I don't think you can enforce stdout/stderr to be synchronous.
> Well, you can try with "stdbuf(1)", but only having coreutils >v7.5
> (2009).  Why not check the output of both streams separately?

Well, it's not about tests (although check both streams separately
will be improvement). The problem is that we write to stderr and
stdout in fdisks, fflush(stdout) before warnings will make things 
more deterministic.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
