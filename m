Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46114 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755404AbbCRLWy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Mar 2015 07:22:54 -0400
Date: Wed, 18 Mar 2015 12:22:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>, util-linux@vger.kernel.org
Subject: Re: question about findmnt --target
Message-ID: <20150318112252.GD28925@ws.net.home>
References: <201503171608.58423.sweet_f_a@gmx.de>
 <20150317163426.GW28925@ws.net.home>
 <55092A36.7060004@bernhard-voelker.de>
 <201503181139.46639.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201503181139.46639.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 18, 2015 at 11:39:45AM +0100, Ruediger Meier wrote:
> On Wednesday 18 March 2015, Bernhard Voelker wrote:
> > On 03/17/2015 05:34 PM, Karel Zak wrote:
> > > Maybe we need a new option to disable the evaluation of the target
> > > path elements. (--strict-target)
> >
> > Hey, we already have a tool for that: 'mountpoint' ;-)
> >
> > What's wrong with
> >
> >   mountpoint "$DIR_B" >/dev/null \
> >     && findmnt --target "$DIR_B" \
> >     && ...
> 
> Yeah! In context of that tests/ts/mount/move snippet this should be 
> enough:
> 
> [...]
> # move
> $TS_CMD_MOUNT --move $DIR_A $DIR_B
> 
> # check the move
> $TS_CMD_MOUNTPOINT -q $DIR_B || ts_failed "Cannot find binded $DIR_B"
> [...]
> 
> I still wonder why we don't check mount's return value too. Here it 
> should always return 0, right?

 check return code is good idea, but please still check the mountpoint
 too. It's mount(8) test - we need an independent verification.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
