Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f181.google.com ([209.85.220.181]:63787 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630Ab3IJHLo convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 10 Sep 2013 03:11:44 -0400
Received: by mail-vc0-f181.google.com with SMTP id hz10so4598046vcb.40
        for <util-linux@vger.kernel.org>; Tue, 10 Sep 2013 00:11:44 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <522D3F3F.3090509@draigBrady.com>
References: <1378656549-3729-1-git-send-email-kerolasa@iki.fi>
	<1378656549-3729-3-git-send-email-kerolasa@iki.fi>
	<522D3F3F.3090509@draigBrady.com>
Date: Tue, 10 Sep 2013 08:11:43 +0100
Message-ID: <CAG27Bk3ZxWFJsNEgzmGcrYPDT43qO8G4Hj6n8pBJEuzi+oSZHQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] lib/fileutils: advice there is no point caching
 temporary files
From: Sami Kerola <kerolasa@iki.fi>
To: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 9 September 2013 04:23, Pádraig Brady <P@draigbrady.com> wrote:
> On 09/08/2013 05:09 PM, Sami Kerola wrote:
>> +#ifdef POSIX_FADV_NOREUSE
>> +     posix_fadvise(fd, 0, lseek(fd, 0, 0), POSIX_FADV_NOREUSE);
>> +#endif
>
> I don't follow. The above is saying to NOREUSE the data
> from the start to the current position?
> But won't the file be empty and the current position == 0 here?
> Also POSIX_FADV_NOREUSE currently does nothing in the kernel.
> There is POSIX_FADV_DONTNEED to drop the file (range) from cache.
> But I'm not sure that's appropriate or needed for all temp files?
> Note also DONTNEED is auto done when a file is unlinked.

Hi Pádraig,

I misunderstood posix_fadvice() manual page. Thank you for explaining
how caching instructions work. Perhaps adding a note to
posix_fadvise(3P) about unlinking and DONOTNEED would be appropriate.
That, after all, makes manual fiddling with this function pointless in
cases like I proposed.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
