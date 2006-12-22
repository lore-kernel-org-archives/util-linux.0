Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from deepthought.armory.com ([192.122.209.42]:3616 "HELO armory.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1945955AbWLVHqH (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 22 Dec 2006 02:46:07 -0500
Date: Thu, 21 Dec 2006 23:45:53 -0800
From: Evan Hunt <ethanol@armory.com>
To: Albert Cahalan <acahalan@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, Bryan Henderson <bryanh@giraffe-data.com>,
        ams@gnu.org, P@draigbrady.com, util-linux-ng@vger.kernel.org
Subject: Re: splitting util-linux (was: kill)
Message-ID: <20061222074553.GA18589@armory.com>
References: <787b0d920612192242x3788f4bfh3be846d4188e3767@mail.gmail.com> <20061220085706.GH5971@petra.dvoda.cz> <45890A78.1030105@draigBrady.com> <20061220104547.GJ5971@petra.dvoda.cz> <20061220214503.0BB4744007@Psilocybe.Update.UU.SE> <20061220235519.GN5971@petra.dvoda.cz> <20061221041033.GB13134@armory.com> <80765.bryanh@giraffe-data.com> <20061221215312.GP5971@petra.dvoda.cz> <787b0d920612212212s1ca3179jf037fc71f3f28498@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <787b0d920612212212s1ca3179jf037fc71f3f28498@mail.gmail.com>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


> As far as I can see, "look" is basically a lame grep.
> Is this something we really need?

Yes, it is.  If you're looking up matching lines in a very large file,
repeatedly, a binary search can be much, much faster than a linear regular-
expression search.  I've written quite a lot of scripts that used look to
good effect.  Here, check out this factor-300 speedup:

    $ time look borealis
    Borealis
    borealis

    real    0m0.003s
    user    0m0.000s
    sys     0m0.004s

    $ time grep -y borealis /usr/share/dict/words
    Borealis
    borealis

    real    0m0.990s
    user    0m0.944s
    sys     0m0.024s

However, you're right about it being lame.  It only searches at the
beginning of the line, making it useless for files that are sorted on
different fields, can only deal with lexical ordering, etc.

I'm fixing this, which is part of why I ended up in this conversation
in the first place; I want to put the improved version into miscutils.

> more -- still better-known than "less", sadly

Ah, a pet peeve of mine. :)

Why doesn't the 'less' package just install 'more' as a link to 'less'?
SCO did that years ago, and nobody ever missed the old version.  And I got
used to "more" being a decent pager, and now every time I try to use it on
linux, I get this annoying broken version...

Evan Hunt

