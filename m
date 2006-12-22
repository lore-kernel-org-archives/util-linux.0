Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from deepthought.armory.com ([192.122.209.42]:1269 "HELO armory.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750939AbWLVQws (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 22 Dec 2006 11:52:48 -0500
Date: Fri, 22 Dec 2006 08:52:39 -0800
From: Evan Hunt <ethanol@armory.com>
To: Karel Zak <kzak@redhat.com>
Cc: Albert Cahalan <acahalan@gmail.com>,
        Bryan Henderson <bryanh@giraffe-data.com>, ams@gnu.org,
        P@draigbrady.com, util-linux-ng@vger.kernel.org
Subject: Re: splitting util-linux (was: kill)
Message-ID: <20061222165239.GC757@armory.com>
References: <20061220214503.0BB4744007@Psilocybe.Update.UU.SE> <20061220235519.GN5971@petra.dvoda.cz> <20061221041033.GB13134@armory.com> <80765.bryanh@giraffe-data.com> <20061221215312.GP5971@petra.dvoda.cz> <787b0d920612212212s1ca3179jf037fc71f3f28498@mail.gmail.com> <20061222074553.GA18589@armory.com> <20061222080721.GS5971@petra.dvoda.cz> <20061222084521.GB10592@armory.com> <20061222110352.GV5971@petra.dvoda.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061222110352.GV5971@petra.dvoda.cz>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


>  Hmm... I can imagine faster things based on possition (so you call
>  seek()) rather than on the serial number. But it's completely different
>  topic.

Something like that is coming next, as a matter of fact.  But yes,
different topic.

>  And why we cannot use two tools for these two different jobs/formats? 

Because it's an unnecessary duplication of code, because it's trivially
easy to have my tool run in a "look"-equivalent mode, and because I imagine
there may be some other shell script author out there in the world who's
been using "look" for this purpose for a long time and would be pleased
to find it suddenly having a smarter set of options.

>  I really don't see any reason why we should merge these search tools
>  to one monolithic tool. There's many different formats how you can
>  organize your data and I think it's normal that we have separated
>  tools for every format. 

Then why not different tools for organizing it?  Instead of using 
"sort --ignore-case --dictionary-order --unique", why not have a
single-purpose "dictsort" tool to generate the input for "look"?  ;)

I'm kidding, here, but my point is serious:  Flexible tools that can
serve many purposes are better than inflexible ones that only serve
one, and if you have a flexible tool that serves your purpose equally
well or better, then there's no need to keep the inflexible ones around.

(I'm not sure this conversation still needs to be on the util-linux-ng
list, sorry if I'm hijacking it...)

Evan Hunt

