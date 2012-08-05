Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:11601 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754009Ab2HECCT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 4 Aug 2012 22:02:19 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7522ImN027293
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Sat, 4 Aug 2012 22:02:18 -0400
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q7522G5u029576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <util-linux@vger.kernel.org>; Sat, 4 Aug 2012 22:02:17 -0400
Message-ID: <501DD427.5070004@draigBrady.com>
Date: Sun, 05 Aug 2012 03:02:15 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: suggestion to avoid erroneous lines in findmnt/lslocks/...
References: <501D42D2.6050904@draigBrady.com> <20120804155755.GJ529@rampage>
In-Reply-To: <20120804155755.GJ529@rampage>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/04/2012 04:57 PM, Dave Reisner wrote:
> On Sat, Aug 04, 2012 at 04:42:10PM +0100, Pádraig Brady wrote:
>> There was a recent change in df in coreutils to sanitize output of paths:
>>
>> http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=commitdiff;h=3ed70fd
>>
>> The essential issue fixed there is that control chars in a path will be
>> converted to '?' (this works in all locales), and doing so will mean
>> '\n' for example is not output. You could even consider this a potential
>> security improvement so that arbitrary users couldn't influence the
>> output of these commands for all users.
>>
>> I suggest using the simple inplace replacement function from above.
> 
> Why replace with a bogus character when you could instead use an octal
> or hex escape? Wouldn't this still address the underlying problem?
> Munging the content of a string could break a script consuming the
> output with no way for the script to recover.

Yes true.
I suppose you could use octal escapes, so 0x00 -> 0x1F are
mapped to \000 -> \037 and '\' is mapped to \134

That's more invasive though.
For df for now at least it was thought that
requiring unambiguous output for these names was overkill.
The names were adjusted just so as to avoid processing issues
for other sanely named items.

Also related is the issue of non printable characters.
For example if you view the unicode line separator char
(\u2028) in certain places (like a pango editor like gedit for example)
it will appear as a normal new line.
It might be appropriate to replace or escape all non printable chars.
That's complicated though (mbsalign in util-linux already does
this to some extent).

So you could have complex mappings, but I was
thinking at least for these utils a simple method
is appropriate to avoid the immediate issue.

cheers,
Pádraig.
