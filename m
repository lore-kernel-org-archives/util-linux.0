Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:6777 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab2EYHlR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 May 2012 03:41:17 -0400
Date: Fri, 25 May 2012 09:41:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PULL] su
Message-ID: <20120525074111.GB1177@x2.net.home>
References: <4FBE3059.3030806@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FBE3059.3030806@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 24, 2012 at 02:58:01PM +0200, Ludwig Nussel wrote:
> coreutils isn't really interested in maintaining su anymore.
> Distributions have to add custom patches to fix bugs and add
> features. The worst offender is probably the pam patch. Fortunately
> we managed to sync the patch between openSUSE and Fedora meanwhile.
> Over time the risk that the patches divert again increases though.
> Since util-linux now contains a common login program it looks like a
> good new home for su too.
> 
> To integrate su into util-linux I've extracted the history of the su
> program until the last GPLv2 version (they've changed to GPLv3
> meanwhile) from coreutils' git and merged it with util-linux.
> Then I've added the patches used in Fedora and openSUSE and fixed the
> files to actually build.

 Good work, thanks.

> You can find the result in branch su-v1 (ff6b15d) at
> git@github.com:lnussel/util-linux.git
> 
> I've also filed a pull request on github:
> https://github.com/karelzak/util-linux/pull/10
> 
> Originally I had planned to implement separate tty allocation for
> the child program on top of that to get rid of the evil setsid
> patch. It turned out to be more complicated than I thought though. The
> change would be too massive to backport anyways I guess. So the next
> step would be to rip out the non-pam legacy stuff and clean up the code
> to make it readable again.

 It would be nice to cleanup the code (remove non-PAM stuff) before
 merge. Can you do this in your su branch? Please.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
