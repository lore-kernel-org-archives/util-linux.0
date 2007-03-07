Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52925 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992474AbXCGTBz (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 7 Mar 2007 14:01:55 -0500
Date: Wed, 7 Mar 2007 20:01:37 +0100
From: Karel Zak <kzak@redhat.com>
To: David Brownell <david-b@pacbell.net>
Cc: List util-linux-ng <util-linux-ng@vger.kernel.org>
Subject: Re: what happend with hwclock patches?
Message-ID: <20070307190137.GA26835@petra.dvoda.cz>
References: <200703062006.27793.david-b@pacbell.net> <20070307104257.GC25806@petra.dvoda.cz> <200703070942.49785.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200703070942.49785.david-b@pacbell.net>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 07, 2007 at 09:42:49AM -0800, David Brownell wrote:
> >  There is active development, see "log" in the devel branch:
> > 
> >    http://git.kernel.org/?p=utils/util-linux-ng/util-linux-ng.git;a=log;h=devel
> 
> Well, by active development I included "merging patches submitted" e.g. hwclock,

Sure, but the util-linux-ng is still not in the condition when I'll
merging patches ASAP. There are tons of others and more important
patches, there wasn't any tests, there was broken build system ...
Don't forget that the code has been unmaintained for almost 2 years.

Please, be patient at least for next 1-2 months.

BTW, "active" also means that someone answers your mails. I hope you
see the change :-)))

> but it's also rather conventional to have patches show up on mainline instead of
> only on branches.  See for example the kernel tree, or essentially any other tree...
> 
> It stiil doesn't *show* that development in the usual way.  Attributing the issue
> to gitweb isn't relevant; lots of people don't know more than "git pull", and if
> that doesn't give them updates, they effectively didn't happen.

$ git clone git://git.kernel.org/pub/scm/utils/util-linux-ng/util-linux-ng.git util-linux-ng
$ git checkout -f devel
$ git log

Well, we're very exotic. We use branches.

There is:

$ cat .git/remotes/origin
URL: git://git.kernel.org/pub/scm/utils/util-linux-ng/util-linux-ng.git
Pull: refs/heads/master:refs/heads/origin
Pull: refs/heads/devel:refs/heads/devel

after "git clone", so I don't see any problem with "git pull". You
should see updates in the 'devel' branch as well.

Also see:
    http://userweb.kernel.org/~kzak/util-linux-ng/


I believe there is more light now :-)

      Karel

-- 
 Karel Zak  <kzak@redhat.com>
