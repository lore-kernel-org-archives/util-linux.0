Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from adsl-64-171-19-66.dsl.sntc01.pacbell.net ([64.171.19.66]:4195
	"EHLO giraffe.giraffe-data.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423218AbWLVHLs (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 22 Dec 2006 02:11:48 -0500
Message-ID: <42767.bryanh@giraffe-data.com>
Date: 22 Dec 2006 06:44:21 +0000
From: bryanh@giraffe-data.com (Bryan Henderson)
To: kzak@redhat.com
CC: ethanol@armory.com, ams@gnu.org, P@draigbrady.com, acahalan@gmail.com,
        util-linux-ng@vger.kernel.org
In-reply-to: <20061221215312.GP5971@petra.dvoda.cz> (kzak@redhat.com)
Subject: Re: splitting util-linux (was: kill)
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com> <20061220085706.GH5971@petra.dvoda.cz> <45890A78.1030105@draigBrady.com> <20061220104547.GJ5971@petra.dvoda.cz> <20061220214503.0BB4744007@Psilocybe.Update.UU.SE> <20061220235519.GN5971@petra.dvoda.cz> <20061221041033.GB13134@armory.com> <80765.bryanh@giraffe-data.com> <20061221215312.GP5971@petra.dvoda.cz>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> That's not 100% true. You need upstream and downstream maintainer for
> every package. You need an infrastructure (scm, mailing list, ...)
> for every package. Maybe it seems like something simple (10 clicks at
> sf.net), but my experience is completely different. Maintainig is
> really boring work and after few months nobody wants to do it... 
> 
> Number of well maintained packages is not so big. Believe me, people
> who work on Linux distributions fight with unmaintained projects every
> day.

If you're willing to do all that work for all of the components of
util-linux, or alternatively if most of the components simply don't
require any maintenance, then the labor-distributing advantage of
splitting isn't there.  And you've obviously determined that you can
distribute one big package more easily than lots of little ones
(myself, I've found the opposite -- I split things up into independent
parts so that I can release in smaller doses).

That still leaves the flexibility hit for users, since it's extra work
to install just what you want or upgrade just one piece without
disturbing other pieces.

But never mind.  I brought it up in case you had thoughts in the same
vein; since you don't, I know emails from me won't change that.

-- 
Bryan Henderson                                    Phone 408-621-2000
San Jose, California
