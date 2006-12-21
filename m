Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from deepthought.armory.com ([192.122.209.42]:3881 "HELO armory.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1422763AbWLUGhw (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 21 Dec 2006 01:37:52 -0500
Date: Wed, 20 Dec 2006 20:10:33 -0800
From: Evan Hunt <ethanol@armory.com>
To: Karel Zak <kzak@redhat.com>
Cc: "Alfred M. Szmidt" <ams@gnu.org>, P@draigbrady.com, acahalan@gmail.com,
        util-linux-ng@vger.kernel.org
Subject: Re: kill
Message-ID: <20061221041033.GB13134@armory.com>
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com> <20061220085706.GH5971@petra.dvoda.cz> <45890A78.1030105@draigBrady.com> <20061220104547.GJ5971@petra.dvoda.cz> <20061220214503.0BB4744007@Psilocybe.Update.UU.SE> <20061220235519.GN5971@petra.dvoda.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061220235519.GN5971@petra.dvoda.cz>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


>  Well, from my Linux egoistic point of view there is nothing what I have
>  to change with look or cal. 
>  
>  Yes, I don't have care about others systems and it seems that the
>  others systems don't have care about look or cal. I really don't see
>  anywhere any real request for this change. 

Well, I'm currently working on an improved version of look, and would
prefer it to be OS-agnostic rather than living in a package that has
"linux" in its name.  So I think moving look out of util-linux(-ng)
and into something more generic would be a good thing to do.

I don't have a personal stake in cal, but I do think, like look, that
it's a widely-useful tool and it seems somewhat odd for it to be grouped
in with tools that are platform-specific.

I'd say the same about several other things in util-linux... col, colcrt,
colrm, column, getopt, hexdump, logger, more, namei, pg, rename, rev,
script, ul, and write all seem quite generic.  (Also ddate, though I'd
categorize that as a game rather than a utility anyway.)

                                        eh

