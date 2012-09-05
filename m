Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:49911 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab2IEKOl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 5 Sep 2012 06:14:41 -0400
Message-ID: <5047260E.9070607@bernhard-voelker.de>
Date: Wed, 05 Sep 2012 12:14:38 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: su: (why not?) merged from latest coreutils
References: <504624F3.2020601@bernhard-voelker.de> <20120905093907.GC32623@x2.net.home>
In-Reply-To: <20120905093907.GC32623@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On 09/05/2012 11:39 AM, Karel Zak wrote:
>> code fixes, copyright year number changes etc. but at least the following
>> seem to be worth including:
>>  
>>   71b7ddc port to GNU hosts, where getuid and friends can fail
>>   1c59bb3 nice, nohup, su: detect write failure to stderr
>
>  Fixed.

Thanks.

> [PATCH 1/2] su: more robust getpwuid() for GNU Hurt [coreutils 71b7ddc]

Hopefully, the Hurd folk don't feel 'hurt' when reading the commit :-)

> [PATCH 2/2] su: verify writing to streams was successful
> [...]
> +  atexit(close_stdout);

I'm not sure this was meant by 1c59bb3. As su calls execvp(),
close_stdout won't have a chance to run.
See the comment in the original patch:

+  /* error() flushes stderr, but does not check for write failure.
+     Normally, we would catch this via our atexit() hook of
+     close_stdout, but execvp() gets in the way.  If stderr
+     encountered a write failure, there is no need to try calling
+     error() again, particularly since we may have just changed the
+     underlying fd out from under stderr.  */
+  if (ferror (stderr))
+    exit (exit_internal_failure);


>> and these would be nice:
>> 
>>   a517386 maint: src/*.c: change remaining quotes (without embedded spaces)
>
>  It seems that `foo' quotes is a generic problem in our code. Not sure
>  why this is so important.

I personally have always wondered about that asymetric quoting was chosen.
GNU standards now say that 'foo' is to be used, so I propose to also
change UL programs. Something like this would be a good start (untested):

  $ git grep -l "\`[^']*'" |xargs perl -pi -e "s/\`(.*?')/'\$1/g"

WDYT?

Have a nice day,
Berny
