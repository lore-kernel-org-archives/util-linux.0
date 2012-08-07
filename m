Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45357 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932504Ab2HGXgJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Aug 2012 19:36:09 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q77Na8sD029278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 7 Aug 2012 19:36:08 -0400
Message-ID: <5021A665.9060305@draigBrady.com>
Date: Wed, 08 Aug 2012 00:36:05 +0100
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: suggestion to avoid erroneous lines in findmnt/lslocks/...
References: <501D42D2.6050904@draigBrady.com> <20120806081533.GA24621@x2.net.home> <20120806111059.GB24621@x2.net.home> <501FD845.50001@draigBrady.com> <20120807080939.GF24621@x2.net.home>
In-Reply-To: <20120807080939.GF24621@x2.net.home>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/07/2012 09:09 AM, Karel Zak wrote:
> On Mon, Aug 06, 2012 at 03:44:21PM +0100, Pádraig Brady wrote:
>> I did a quick test...
> 
>  Thanks, I'll use it in regression tests ;-) (I was busy yesterday to
>  write any reg.tests.)
> 
>> TARGET                 SOURCE     FSTYPE OPTIONS
>> /home/padraig/tst/ascii /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
>> /home/padraig/tst/ascii
>> TARGET                       SOURCE     FSTYPE OPTIONS
>> /home/padraig/tst/co\x0atrol /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
>> /home/padraig/tst/co\x0atrol
>> TARGET                       SOURCE     FSTYPE OPTIONS
>> /home/padraig/tst/back\slash /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
>> /home/padraig/tst/back\slash
>> TARGET                       SOURCE     FSTYPE OPTIONS
>> /home/padraig/tst/es\x63aped /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
>> /home/padraig/tst/es\x5cx63aped
>> TARGET SOURCE     FSTYPE OPTIONS
>>
>>        /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
>> /home/padraig/tst/non\xfffffffatf8
>> TARGET                         SOURCE     FSTYPE OPTIONS
>> /home/padraig/tst/日一二三四五六 /dev/loop1 ext2   rw,relatime,seclabel,errors=continue
>> /home/padraig/tst/\xffffffe6\xffffff97...
>>
>> So two questions.
>>
>> 1. Should the back\slash case be back\x5cslash in both cases?
> 
>  back\slash is not \x<xdigit> sequence, so escape is unnecessary
> 
>  Note that \\server\path is pretty common for cifs and use \x5c
>  for all '\' will make the findmnt output unreadable in many cases.
>  IMHO is better to be "smart" and use escape sequences only when it's
>  really necessary.

Better for humans, but awkward for scripts to parse.
What I was thinking was perhaps --raw or -P would
do unconditional escaping of '\' so unescaping can be
done with just `printf %b`?

With the conditional escaping you'd have to do something like:

unmangle() {
  printf '%b' $(
    sed '
      s/\\\([^x]\)/\\x5c\1/g;
      s/\\\(x[^0-9a-f]\)/\\x5c\1/g;
      s/\\\(x[0-9a-f][^0-9a-f]\)/\\x5c\1/g;
    '
  )
}

> 
>> 2. The nonútf8 one produces an errant new line.
>> Also in this case could you fall back to using \x escapes for the whole string?
> 
>  Yeah, nonútf8 output seems strange, I'll fix it.
> 
> 
>  I'll also update findmnt (and others) man pages to explain when and
>  how we use \x escapes. Is there any elegant way how to convert \x
>  sequences back to the native strings in shell? Maybe we can add some
>  hint to the man pages too.

cheers,
Pádraig.
