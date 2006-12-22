Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:45886 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965157AbWLVMcd (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 22 Dec 2006 07:32:33 -0500
Subject: Re: splitting util-linux (was: kill)
From: Ian Kent <ikent@redhat.com>
To: Karel Zak <kzak@redhat.com>
Cc: Evan Hunt <ethanol@armory.com>, Albert Cahalan <acahalan@gmail.com>,
        Bryan Henderson <bryanh@giraffe-data.com>, ams@gnu.org,
        P@draigbrady.com, util-linux-ng@vger.kernel.org
In-Reply-To: <20061222080721.GS5971@petra.dvoda.cz>
References: <20061220085706.GH5971@petra.dvoda.cz>
	 <45890A78.1030105@draigBrady.com> <20061220104547.GJ5971@petra.dvoda.cz>
	 <20061220214503.0BB4744007@Psilocybe.Update.UU.SE>
	 <20061220235519.GN5971@petra.dvoda.cz> <20061221041033.GB13134@armory.com>
	 <80765.bryanh@giraffe-data.com> <20061221215312.GP5971@petra.dvoda.cz>
	 <787b0d920612212212s1ca3179jf037fc71f3f28498@mail.gmail.com>
	 <20061222074553.GA18589@armory.com>  <20061222080721.GS5971@petra.dvoda.cz>
Content-Type: text/plain
Date: Fri, 22 Dec 2006 21:32:28 +0900
Message-Id: <1166790748.4348.7.camel@raven.themaw.net>
Mime-Version: 1.0
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 2006-12-22 at 09:07 +0100, Karel Zak wrote:
> On Thu, Dec 21, 2006 at 11:45:53PM -0800, Evan Hunt wrote:
> > 
> > > As far as I can see, "look" is basically a lame grep.
> > > Is this something we really need?
> > 
> > However, you're right about it being lame.  It only searches at the
> > beginning of the line, making it useless for files that are sorted on
> > different fields, can only deal with lexical ordering, etc.
> 
>  Yes, the definition of "look" is pretty exact. Who do you think that
>  the tool should be work with any other type of files or with
>  a different ordering ? Now, it seems like right tool for right job.
> 
> > I'm fixing this, which is part of why I ended up in this conversation
> > in the first place; I want to put the improved version into miscutils.
> > 
> > > more -- still better-known than "less", sadly
> > 
> > Ah, a pet peeve of mine. :)
> > 
> > Why doesn't the 'less' package just install 'more' as a link to 'less'?
> 
>  because some distributions have the 'more' command in the root
>  filesystem (/bin) and the 'less' command in /usr/bin.

And because some people remember that stuff like this was done because
"/usr" may have been on a separate partition and this was the place to
put binaries that depended on a larger number of libraries, usually also
in "/usr/lib". Then in recovery situations such as single user mode only
"/" would be mounted. Same story with "/bin/sh" of course.

Those days may be behind us but I still think we should be able to boot
a minimal root filesystem for recovery, but perhaps I'm just old
fashioned.

>  But yes, I agree that the 'more' should be die in some future release.
> 
>     Karel
> 

