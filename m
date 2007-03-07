Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:32968 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965026AbXCGKnH (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 7 Mar 2007 05:43:07 -0500
Date: Wed, 7 Mar 2007 11:42:57 +0100
From: Karel Zak <kzak@redhat.com>
To: David Brownell <david-b@pacbell.net>
Cc: List util-linux-ng <util-linux-ng@vger.kernel.org>
Subject: Re: what happend with hwclock patches?
Message-ID: <20070307104257.GC25806@petra.dvoda.cz>
References: <200703062006.27793.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200703062006.27793.david-b@pacbell.net>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 06, 2007 at 08:06:27PM -0800, David Brownell wrote:
> See
>   http://bugzilla.kernel.org/show_bug.cgi?id=8138

 Thanks for this link. The patch is not applied yet. Maybe I should
 release a snapshot (at least) with urgent things like hwclock or some
 mount patches.

 But I think you should ask downstream (your distribution) maitainer
 to apply these kind of patches. They have pretty stable util-linux
 packages now. I'll need few weeks to prepare useful util-linux-ng release.

 (I'm going to add the patch to Fedora tree.)

> I see there's a GIT archive but you don't seem to have merged the patch I sent
> you back in November ... and the GIT tree doesn't show any active development,
> no commits except syncing to old releases.

 Please, don't use broken gitweb at kernel.org or use it very carefully.

 There is active development, see "log" in the devel branch:

   http://git.kernel.org/?p=utils/util-linux-ng/util-linux-ng.git;a=log;h=devel

 Number of applied patches:

    $ git rev-list --pretty=oneline  devel ^master | wc -l
    52

 Number of patches in queue:

    $ ls util-* | wc -l
    49

 The good news is that I have more time and I work on that full time
 now.

        Karel

-- 
 Karel Zak  <kzak@redhat.com>
