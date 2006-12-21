Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from adsl-64-171-19-66.dsl.sntc01.pacbell.net ([64.171.19.66]:1723
	"EHLO giraffe.giraffe-data.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422979AbWLURAB (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 21 Dec 2006 12:00:01 -0500
Message-ID: <80765.bryanh@giraffe-data.com>
Date: 21 Dec 2006 16:34:00 +0000
From: bryanh@giraffe-data.com (Bryan Henderson)
To: ethanol@armory.com
CC: kzak@redhat.com, ams@gnu.org, P@draigbrady.com, acahalan@gmail.com,
        util-linux-ng@vger.kernel.org
In-reply-to: <20061221041033.GB13134@armory.com> (ethanol@armory.com)
Subject: Re: splitting util-linux (was: kill)
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com> <20061220085706.GH5971@petra.dvoda.cz> <45890A78.1030105@draigBrady.com> <20061220104547.GJ5971@petra.dvoda.cz> <20061220214503.0BB4744007@Psilocybe.Update.UU.SE> <20061220235519.GN5971@petra.dvoda.cz> <20061221041033.GB13134@armory.com>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I have thought for many years that util-linux is obsolete.  When it
was new, it was a quite helpful distribution of components with which
to build a system.  Today, we have a plethora of giant Linux distros,
sourceforge, and freshmeat.  Such things eliminate most of the
original value in having one big tarball.  In fact, the amalgamation
of unrelated tools now causes more pain than convenience, because you
often want some parts of the package but not others (as evidenced in
the 'kill' discussion).  We also seem to have a maintainership
problem, since there are people who are willing to maintain some
pieces, but less energetic about maintaining the entire package or
working through a central bureaucracy.

Forking of util-linux is the ideal time to improve this.  Just don't
fork the whole package; fork the part you're interested in.  The
discussion I've seen so far shows the interest mainly in the
filesystem tools, so maybe we should just have a new linuxfs-util (and
use linuxfs-devel mailing list).  (Even that would be too big a
package for my taste.  The Minix utilities should be in a package of
their own).

-- 
Bryan Henderson                                    Phone 408-621-2000
San Jose, California
