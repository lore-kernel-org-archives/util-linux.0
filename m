Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24257 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616Ab2HTAbz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 19 Aug 2012 20:31:55 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7K0Vtio024974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Sun, 19 Aug 2012 20:31:55 -0400
Message-ID: <50318578.70402@draigBrady.com>
Date: Mon, 20 Aug 2012 01:31:52 +0100
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: suggestion to avoid erroneous lines in findmnt/lslocks/...
References: <501D42D2.6050904@draigBrady.com> <20120806081533.GA24621@x2.net.home> <20120806111059.GB24621@x2.net.home> <501FD845.50001@draigBrady.com> <20120807080939.GF24621@x2.net.home> <5021A665.9060305@draigBrady.com> <20120813123921.GB3533@x2.net.home>
In-Reply-To: <20120813123921.GB3533@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/13/2012 01:39 PM, Karel Zak wrote:
> On Wed, Aug 08, 2012 at 12:36:05AM +0100, Pádraig Brady wrote:
>> ck\slash is not \x<xdigit> sequence, so escape is unnecessary
>>>
>>>  Note that \\server\path is pretty common for cifs and use \x5c
>>>  for all '\' will make the findmnt output unreadable in many cases.
>>>  IMHO is better to be "smart" and use escape sequences only when it's
>>>  really necessary.
>>
>> Better for humans, but awkward for scripts to parse.
>> What I was thinking was perhaps --raw or -P would
>> do unconditional escaping of '\' so unescaping can be
>> done with just `printf %b`?
> 
>  Good point. Fixed, all '\' will be replaced with \x5c.

Excellent.
I've tested using the previous test case,
and output is as expected (including the
invalid UTF8 case).

cheers,
Pádraig.
