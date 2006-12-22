Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from deepthought.armory.com ([192.122.209.42]:2783 "HELO armory.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1945987AbWLVIp3 (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 22 Dec 2006 03:45:29 -0500
Date: Fri, 22 Dec 2006 00:45:21 -0800
From: Evan Hunt <ethanol@armory.com>
To: Karel Zak <kzak@redhat.com>
Cc: Albert Cahalan <acahalan@gmail.com>,
        Bryan Henderson <bryanh@giraffe-data.com>, ams@gnu.org,
        P@draigbrady.com, util-linux-ng@vger.kernel.org
Subject: Re: splitting util-linux (was: kill)
Message-ID: <20061222084521.GB10592@armory.com>
References: <45890A78.1030105@draigBrady.com> <20061220104547.GJ5971@petra.dvoda.cz> <20061220214503.0BB4744007@Psilocybe.Update.UU.SE> <20061220235519.GN5971@petra.dvoda.cz> <20061221041033.GB13134@armory.com> <80765.bryanh@giraffe-data.com> <20061221215312.GP5971@petra.dvoda.cz> <787b0d920612212212s1ca3179jf037fc71f3f28498@mail.gmail.com> <20061222074553.GA18589@armory.com> <20061222080721.GS5971@petra.dvoda.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061222080721.GS5971@petra.dvoda.cz>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


>  Yes, the definition of "look" is pretty exact. Who do you think that
>  the tool should be work with any other type of files or with
>  a different ordering ? Now, it seems like right tool for right job.

It works well for looking up words in a dictionary file.  It doesn't work
very well for looking up lines in a flat-file database.

Consider a flat file like the following, each line containing a name,
a serial number, and some additional information.  Each time a new
transaction comes in, the serial number is incremented and a record
is added to the end of the file:

John:White:1:...
Mary:Brown:2:...
Fred:Green:3:...

...and so on.  Now, if that file grows very large, it would be useful to
be able to rapidly search it based on the serial number, e.g., something
like this:

$ search -n -t: -k3 97273 <filename>

Right now, the closest you can get to this with a standard unix or linux
tool is to use "look", but that only works if the serial number is the
first field of the file... and even then it doesn't work very well, because
the file has to be lexically sorted, so the serial numbers would all have
to be padded to the same length with leading zeroes.  It's faster than
using awk or grep, but it's a hassle.

I must have written a dozen shell scripts over the years that would have
been faster and easier to write if a tool like this had existed, and I
can't be the only one...

So I've finally gotten around to writing such a tool, and I'm calling
it "search" or "bs" (for "binary search") or something along those lines.
But I figured, well, it's almost identical to "look" when called without
arguments, so why not just supplant the existing "look"?  If it's invoked
as "look <word>", then it looks up the word in /usr/share/dict/words; if
it's invoked as "search -args <word> <filename>" then it's a general-
purpose binary search tool.

I'm still playing with it, but I plan to have it ready to contribute in
another few days.

Evan Hunt

