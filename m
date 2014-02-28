Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.131]:60454 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbaB1Ity (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 28 Feb 2014 03:49:54 -0500
Message-ID: <53104DB0.6030305@bernhard-voelker.de>
Date: Fri, 28 Feb 2014 09:49:52 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: chcpu exit code?
References: <530F0972.3040205@bernhard-voelker.de> <20140228075355.GB4216@osiris>
In-Reply-To: <20140228075355.GB4216@osiris>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 02/28/2014 08:53 AM, Heiko Carstens wrote:
> The question is: what should chcpu return if it partially succeeded?
>
> # chcpu -d 3-4
> CPU 3 disabled
> CPU 4 does not exist
>
> If I remember correctly this was the reason to make it always return 0.
>
> However, it is indeed valid to say if *everything* failed, it should
> return an error. Hm?

Indeed, e.g. df(1) also fails if only a single mount point
cannot be listed.  Otherwise, the calling script could not rely
on the exit code, and would still have to fall back to parsing
the output.

But thanks to your question I was reminded to have a look
at *where* chcpu writes messages:

   $ chcpu -d 3-4 > /dev/null
   $ chcpu -d 3-4 2> /dev/null
   CPU 3 is already disabled
   CPU 4 does not exist
   $

I.e. chcpu does not write the error diagnostic to stderr ... humm.

Have a nice day,
Berny

