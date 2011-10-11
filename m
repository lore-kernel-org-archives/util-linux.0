Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50111 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170Ab1JKIOc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Oct 2011 04:14:32 -0400
Date: Tue, 11 Oct 2011 10:14:25 +0200
From: Karel Zak <kzak@redhat.com>
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: Dave Reisner <d@falconindy.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH 1/2] mountpoint: refactor exit path
Message-ID: <20111011081425.GA20392@nb.net.home>
References: <1318288456-22940-1-git-send-email-dreisner@archlinux.org> <7856072A9D04C24B82DFE2B1112FE38A0D83B8E942@MCHP058A.global-ad.net> <20111011074427.GH11730@nb.net.home> <7856072A9D04C24B82DFE2B1112FE38A0D83B8E98F@MCHP058A.global-ad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A0D83B8E98F@MCHP058A.global-ad.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 11, 2011 at 09:55:43AM +0200, Voelker, Bernhard wrote:
> Karel Zak wrote:
> 
> > On Tue, Oct 11, 2011 at 09:07:15AM +0200, Voelker, Bernhard wrote:
> > > > +finish:
> > > > +	return rc;
> > > 
> > > IMHO 'goto' is ugly and should only be used in more difficult
> > > cases. In this case - if you really liked to avoid several
> > > free(spec) statements - it could be easily done with a few
> > > else statements.
> 
> 
> > BTW, now you know why I don't like free-before-exit in simple utils
> > like mountpoint(1). It makes code less readable and needlessly
> > complicated.
> 
> no worries. I'm okay with it if you are. ;-)
> 
> Re free-before-exit: the problem is in tools like valgrind.

 Yes if we want to use mountpoint(1) as a test (referential)
 application for libmount, otherwise it's better to keep so small
 utils simple and stupid. 

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
