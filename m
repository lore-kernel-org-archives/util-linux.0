Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932146AbcLIIyp (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 9 Dec 2016 03:54:45 -0500
Date: Fri, 9 Dec 2016 09:54:44 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: Marian Vomir <marian.vomir@ni.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "hwclock: don't allow non-root access"
Message-ID: <20161209085444.uosidcchvme23zts@ws.net.home>
References: <1481047580-28284-1-git-send-email-marian.vomir@ni.com>
 <c0ddbe5a-caa4-c8ad-0d86-9b13c3277edc@gmx.com>
 <20161207112541.2g3trc26tcvcghio@ws.net.home>
 <82bcda5b-fe4e-553a-fa1f-32c37f3fba54@gmx.com>
 <20161209085239.hw7lnkaj5curgh2t@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161209085239.hw7lnkaj5curgh2t@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 09, 2016 at 09:52:39AM +0100, Karel Zak wrote:
> On Thu, Dec 08, 2016 at 09:09:15PM -0500, J William Piggott wrote:
> > On 12/07/2016 06:25 AM, Karel Zak wrote:
> > > Maybe my patch seems too strict, but change docs is not enough, the
> > > code matters. We want to be sure nobody uses hwclock as setuid,
> > > especially if man page and code comments promised this non-sense.
> > 
> > I agree that setuid should be removed from the man-page and source
> > comments. I do not think the code was a problem; removing it does not
> 
> See 687cc5d58942b24a9f4013c68876d8cbea907ab1, it removes many checks.
> It wasn't about comments only.
> 
> > prevent running it with setuid. It only prevents users from access to
> > the benign read only functions of hwclock which they have historically
> > had.
> 
> I agree that kernel is the place where we need to check permissions,
> so I have removed the if (getuid() != 0) 
> 
>     https://github.com/karelzak/util-linux/commit/f4e61504a457395018c02bafcf17d1e3f8644b78
> 
> let's hope nobody uses it as setuid.

 We will need big fat note in the v2.30 ReleaseNotes to make sure
 downstream maintainers don't use it with some extra permissions.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
