Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26538 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103Ab3JKJEv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 11 Oct 2013 05:04:51 -0400
Date: Fri, 11 Oct 2013 11:04:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Craig <util-linux_contact@magister.com.au>
Cc: util-linux@vger.kernel.org
Subject: Re: ***Urgent***!  Fdisk: GPT support utterly breaks hybrid MBR;
 *must* have disable option! :(
Message-ID: <20131011090442.GE14457@x2.net.home>
References: <alpine.LFD.2.03.1310092211290.7406@aslan.magister.com.au>
 <20131009141628.GB940@x2.net.home>
 <alpine.LFD.2.02.1310101129260.4624@trabz.zntvfgre.pbz.nh>
 <20131010111045.GA29199@x2.net.home>
 <alpine.LFD.2.02.1310111435300.6990@trabz.zntvfgre.pbz.nh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.02.1310111435300.6990@trabz.zntvfgre.pbz.nh>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 11, 2013 at 02:45:57PM +1100, Craig wrote:
> On Thu, 10 Oct 2013, Karel Zak <kzak@redhat.com> wrote:
> 
> >Note that in v2.24 the GPT code in fdisk does not allow to write hybrid
> >GPT, the support is read-only.
> 
> Hmm; not good for the long term.  Although a hack and potentially disastrous

 It's temporary solution. 
 
 The long term goal is to support *manual* protective/hybrid MBR
 modification. 
 
 It means that user will be able in expert mode switch to MBR, modify and 
 write MBR to the device and then switch back to GPT. The GPT driver will 
 only print warning, but no overwrite the manually modified MBR.

> if not handled carefully, hybrid MBR really is necessary under certain
> conditions.  Perhaps support should be read-only by default, with a means to
> switch to write, and dire warnings that one is likely severely to break
> things if one isn't careful?  Although it could be argued that those likely
> to be playing with fdisk (rather e.g. than Partid) might be expected to know
> what they're doing. :D To be honest, I'd like to see a means completely to
> separate GPT/MBR changes, so if necessary one could do absolutely anything
> to either without affecting the other.  If somebody is playing around with
> both, then really they should expect to understand what will happen if
> they're careless.

 Yep. I don't want any "smart" solution there. All will be controlled
 by users. 
 
 (Well, in the default mode for non-expert users with standard PMBR we will 
  generate the MBR as expected by UEFI specification of course.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
