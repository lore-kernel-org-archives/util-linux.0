Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:51821 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423046AbWLUVx1 (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 21 Dec 2006 16:53:27 -0500
Date: Thu, 21 Dec 2006 22:53:13 +0100
From: Karel Zak <kzak@redhat.com>
To: Bryan Henderson <bryanh@giraffe-data.com>
Cc: ethanol@armory.com, ams@gnu.org, P@draigbrady.com, acahalan@gmail.com,
        util-linux-ng@vger.kernel.org
Subject: Re: splitting util-linux (was: kill)
Message-ID: <20061221215312.GP5971@petra.dvoda.cz>
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com> <20061220085706.GH5971@petra.dvoda.cz> <45890A78.1030105@draigBrady.com> <20061220104547.GJ5971@petra.dvoda.cz> <20061220214503.0BB4744007@Psilocybe.Update.UU.SE> <20061220235519.GN5971@petra.dvoda.cz> <20061221041033.GB13134@armory.com> <80765.bryanh@giraffe-data.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <80765.bryanh@giraffe-data.com>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 21, 2006 at 04:34:00PM +0000, Bryan Henderson wrote:
> I have thought for many years that util-linux is obsolete.  When it
> was new, it was a quite helpful distribution of components with which
> to build a system.  Today, we have a plethora of giant Linux distros
> sourceforge, and freshmeat.  Such things eliminate most of the
> original value in having one big tarball.  In fact, the amalgamation

 That's not 100% true. You need upstream and downstream maintainer for
 every package. You need an infrastructure (scm, mailing list, ...)
 for every package. Maybe it seems like something simple (10 clicks at
 sf.net), but my experience is completely different. Maintainig is
 really boring work and after few months nobody wants to do it... 
 
 Number of well maintained packages is not so big. Believe me, people
 who work on Linux distributions fight with unmaintained projects every
 day.

> of unrelated tools now causes more pain than convenience, because you
> often want some parts of the package but not others (as evidenced in
> the 'kill' discussion).  We also seem to have a maintainership

 Well, kill is nice example where is not problem remove it from
 util-linux (... because procps). 

> problem, since there are people who are willing to maintain some
> pieces, but less energetic about maintaining the entire package or
> working through a central bureaucracy.

 I don't see any problem collaborate with more people. The
 util-linux-ng really could be the area where we can together improve
 basic Linux utils.

 Maybe I'm blind, but why do you think that the code in look, cal, ...
 will be better if you split util-linux into more small packages?

 People usually fork or split projects if they have a problem with
 collaboration. Is it our actual problem? I don't think so.

 The util-linux exists more than 10 year without fatal problems and I
 think it can exist next 10 years.

> Forking of util-linux is the ideal time to improve this.  Just don't
> fork the whole package; fork the part you're interested in.  The

 No, the motivation for new util-linux upstream is that there is more
 than 100 util-linux patches in Suse, Red Hat or Debian. We're
 interested in whole package and we want to merge changes from
 distribution to this upstream and sync code in util-linux with
 kernel. This is necessary step. 

 BTW, it's not so long time ago when schedutils has been incorporated
 to util-linux. It seems that poeple are able to found reasons why merge
 is better than split :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
