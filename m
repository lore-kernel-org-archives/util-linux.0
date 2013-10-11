Return-Path: util-linux-owner@vger.kernel.org
Received: from magister.com.au ([123.243.98.134]:49829 "EHLO magister.com.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924Ab3JKVfO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 11 Oct 2013 17:35:14 -0400
Date: Sat, 12 Oct 2013 08:34:40 +1100 (EST)
From: Craig <util-linux_contact@magister.com.au>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: ***Urgent***!  Fdisk: GPT support utterly breaks hybrid MBR;
 *must* have disable option! :(
In-Reply-To: <20131011090442.GE14457@x2.net.home>
Message-ID: <alpine.LFD.2.02.1310120828440.3289@trabz.zntvfgre.pbz.nh>
References: <alpine.LFD.2.03.1310092211290.7406@aslan.magister.com.au> <20131009141628.GB940@x2.net.home> <alpine.LFD.2.02.1310101129260.4624@trabz.zntvfgre.pbz.nh> <20131010111045.GA29199@x2.net.home> <alpine.LFD.2.02.1310111435300.6990@trabz.zntvfgre.pbz.nh>
 <20131011090442.GE14457@x2.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 11 Oct 2013, Karel Zak <kzak@redhat.com> wrote:

[...]

> Yep. I don't want any "smart" solution there. All will be controlled
> by users.

> (Well, in the default mode for non-expert users with standard PMBR we will
>  generate the MBR as expected by UEFI specification of course.)

Ah, splendid; glad to hear that.  Then for the moment I'll simply make a 
temporary RPM package with the pre-GPT fdisk; that will do for my 
situation.  I'd rather not faff around with a custom util-linux RPM, 
either which would break updates or not get updated at all.  A separate 
fdisk RPM will do for the moment and will solve my hybrid MBR problem. :)

Cheerio,
Craig
