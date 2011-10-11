Return-Path: util-linux-owner@vger.kernel.org
Received: from senmx12-mx.siemens-enterprise.com ([62.134.46.10]:54544 "EHLO
	senmx12-mx.siemens-enterprise.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752010Ab1JKHzq convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Oct 2011 03:55:46 -0400
From: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
To: Karel Zak <kzak@redhat.com>
CC: Dave Reisner <d@falconindy.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Dave Reisner <dreisner@archlinux.org>
Date: Tue, 11 Oct 2011 09:55:43 +0200
Subject: RE: [PATCH 1/2] mountpoint: refactor exit path
Message-ID: <7856072A9D04C24B82DFE2B1112FE38A0D83B8E98F@MCHP058A.global-ad.net>
References: <1318288456-22940-1-git-send-email-dreisner@archlinux.org>
 <7856072A9D04C24B82DFE2B1112FE38A0D83B8E942@MCHP058A.global-ad.net>
 <20111011074427.GH11730@nb.net.home>
In-Reply-To: <20111011074427.GH11730@nb.net.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:

> On Tue, Oct 11, 2011 at 09:07:15AM +0200, Voelker, Bernhard wrote:
> > > +finish:
> > > +	return rc;
> > 
> > IMHO 'goto' is ugly and should only be used in more difficult
> > cases. In this case - if you really liked to avoid several
> > free(spec) statements - it could be easily done with a few
> > else statements.


> BTW, now you know why I don't like free-before-exit in simple utils
> like mountpoint(1). It makes code less readable and needlessly
> complicated.

no worries. I'm okay with it if you are. ;-)

Re free-before-exit: the problem is in tools like valgrind.
I'm not much into it, but don't they know about 'noreturn'?

Have a nice day,
Berny

