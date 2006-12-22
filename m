Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:40922 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945965AbWLVIHa (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 22 Dec 2006 03:07:30 -0500
Date: Fri, 22 Dec 2006 09:07:21 +0100
From: Karel Zak <kzak@redhat.com>
To: Evan Hunt <ethanol@armory.com>
Cc: Albert Cahalan <acahalan@gmail.com>,
        Bryan Henderson <bryanh@giraffe-data.com>, ams@gnu.org,
        P@draigbrady.com, util-linux-ng@vger.kernel.org
Subject: Re: splitting util-linux (was: kill)
Message-ID: <20061222080721.GS5971@petra.dvoda.cz>
References: <20061220085706.GH5971@petra.dvoda.cz> <45890A78.1030105@draigBrady.com> <20061220104547.GJ5971@petra.dvoda.cz> <20061220214503.0BB4744007@Psilocybe.Update.UU.SE> <20061220235519.GN5971@petra.dvoda.cz> <20061221041033.GB13134@armory.com> <80765.bryanh@giraffe-data.com> <20061221215312.GP5971@petra.dvoda.cz> <787b0d920612212212s1ca3179jf037fc71f3f28498@mail.gmail.com> <20061222074553.GA18589@armory.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061222074553.GA18589@armory.com>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Dec 21, 2006 at 11:45:53PM -0800, Evan Hunt wrote:
> 
> > As far as I can see, "look" is basically a lame grep.
> > Is this something we really need?
> 
> However, you're right about it being lame.  It only searches at the
> beginning of the line, making it useless for files that are sorted on
> different fields, can only deal with lexical ordering, etc.

 Yes, the definition of "look" is pretty exact. Who do you think that
 the tool should be work with any other type of files or with
 a different ordering ? Now, it seems like right tool for right job.

> I'm fixing this, which is part of why I ended up in this conversation
> in the first place; I want to put the improved version into miscutils.
> 
> > more -- still better-known than "less", sadly
> 
> Ah, a pet peeve of mine. :)
> 
> Why doesn't the 'less' package just install 'more' as a link to 'less'?

 because some distributions have the 'more' command in the root
 filesystem (/bin) and the 'less' command in /usr/bin.

 But yes, I agree that the 'more' should be die in some future release.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
