Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52490 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946037AbWLVLEJ (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 22 Dec 2006 06:04:09 -0500
Date: Fri, 22 Dec 2006 12:03:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Evan Hunt <ethanol@armory.com>
Cc: Albert Cahalan <acahalan@gmail.com>,
        Bryan Henderson <bryanh@giraffe-data.com>, ams@gnu.org,
        P@draigbrady.com, util-linux-ng@vger.kernel.org
Subject: Re: splitting util-linux (was: kill)
Message-ID: <20061222110352.GV5971@petra.dvoda.cz>
References: <20061220104547.GJ5971@petra.dvoda.cz> <20061220214503.0BB4744007@Psilocybe.Update.UU.SE> <20061220235519.GN5971@petra.dvoda.cz> <20061221041033.GB13134@armory.com> <80765.bryanh@giraffe-data.com> <20061221215312.GP5971@petra.dvoda.cz> <787b0d920612212212s1ca3179jf037fc71f3f28498@mail.gmail.com> <20061222074553.GA18589@armory.com> <20061222080721.GS5971@petra.dvoda.cz> <20061222084521.GB10592@armory.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061222084521.GB10592@armory.com>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 22, 2006 at 12:45:21AM -0800, Evan Hunt wrote:


> ...and so on.  Now, if that file grows very large, it would be useful
> to be able to rapidly search it based on the serial number, e.g.,
> something like this:

> $ search -n -t: -k3 97273 <filename>

 Hmm... I can imagine faster things based on possition (so you call seek()) rather
 than on the serial number. But it's completely different topic.

> So I've finally gotten around to writing such a tool, and I'm calling
> it "search" or "bs" (for "binary search") or something along those lines.

 No problem.

> But I figured, well, it's almost identical to "look" when called without
> arguments, so why not just supplant the existing "look"?  If it's invoked
> as "look <word>", then it looks up the word in /usr/share/dict/words; if
> it's invoked as "search -args <word> <filename>" then it's a general-
> purpose binary search tool.

 And why we cannot use two tools for these two different jobs/formats? 
 
 I really don't see any reason why we should merge these search tools
 to one monolithic tool. There's many different formats how you can
 organize your data and I think it's normal that we have separated
 tools for every format. 
 
 It really doesn't make sense merge it with 'look' if the 'look' is 
 stupid and simple tool how search in data in files in 
    sort --ignore-case --dictionary-order | uniq
 format. 


  Karel "stubborn" ;-)

-- 
 Karel Zak  <kzak@redhat.com>
