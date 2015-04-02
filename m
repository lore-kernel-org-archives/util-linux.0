Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60067 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719AbbDBTPc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 2 Apr 2015 15:15:32 -0400
Date: Thu, 2 Apr 2015 21:15:30 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org,
        Isaac Dunham <ibid.ag@gmail.com>
Subject: Re: question about hardcoded binary paths (swapon / mkswap)
Message-ID: <20150402191530.GG2097@ws.net.home>
References: <201504011342.56546.sweet_f_a@gmx.de>
 <201504011817.48428.sweet_f_a@gmx.de>
 <20150401201051.GP25224@vapier>
 <201504012306.52737.sweet_f_a@gmx.de>
 <20150401213800.GB2097@ws.net.home>
 <20150402011230.GA22171@vapier>
 <20150402082000.GC2097@ws.net.home>
 <20150402161952.GB22171@vapier>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150402161952.GB22171@vapier>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 02, 2015 at 12:19:52PM -0400, Mike Frysinger wrote:
> On 02 Apr 2015 10:20, Karel Zak wrote:
> > If I good remember then the reason is that the helpers does not have
> > to be installed in standard PATH. Well, you're author of this thing
> > :-)
> 
> i wrote the code to make it a configure option, but the actual behavior predates 
> me.  i'm interested more in the behavior, not the exact configure option.

 So, the basis question is if we really need to support non-standard
 paths for the helpers. IMHO it's unnecessary legacy and I don't see a
 problem to drop this feature and require $PATH, and for critical
 things like fsck fallback to /sbin if $PATH is undefined.

 Comments?

> looks like mkfs added it during the 2.2->2.5 transition, but otherwise no 
> details in the bundled NEWS that i saw.  oh well.

 mkfs is deprecated, the right way is to call directly mkfs.<type>.

> mount makes sense as it's set*id and we can't trust users to not be evil :)

 It does not execute anything with root rights, but yes, hardcoded
 paths make sense there (just to avoid complexity and external
 dependencies on environment).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
