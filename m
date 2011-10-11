Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46773 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984Ab1JKHof (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Oct 2011 03:44:35 -0400
Date: Tue, 11 Oct 2011 09:44:27 +0200
From: Karel Zak <kzak@redhat.com>
To: "Voelker, Bernhard" <bernhard.voelker@siemens-enterprise.com>
Cc: Dave Reisner <d@falconindy.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Dave Reisner <dreisner@archlinux.org>
Subject: Re: [PATCH 1/2] mountpoint: refactor exit path
Message-ID: <20111011074427.GH11730@nb.net.home>
References: <1318288456-22940-1-git-send-email-dreisner@archlinux.org> <7856072A9D04C24B82DFE2B1112FE38A0D83B8E942@MCHP058A.global-ad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7856072A9D04C24B82DFE2B1112FE38A0D83B8E942@MCHP058A.global-ad.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 11, 2011 at 09:07:15AM +0200, Voelker, Bernhard wrote:
> > +finish:
> > +	return rc;
> 
> IMHO 'goto' is ugly and should only be used in more difficult
> cases. In this case - if you really liked to avoid several
> free(spec) statements - it could be easily done with a few
> else statements.


kernel Documentation/CodingStyle:

  Albeit deprecated by some people, the equivalent of the goto statement is
  used frequently by compilers in form of the unconditional jump instruction.

  The goto statement comes in handy when a function exits from multiple
  locations and some common work such as cleanup has to be done.

  The rationale is:

  - unconditional statements are easier to understand and follow
  - nesting is reduced
  - errors by not updating individual exit points when making
    modifications are prevented
  - saves the compiler work to optimize redundant code away ;)


BTW, now you know why I don't like free-before-exit in simple utils
like mountpoint(1). It makes code less readable and needlessly
complicated.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
