Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f47.google.com ([209.85.220.47]:37703 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbaD2VFY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 29 Apr 2014 17:05:24 -0400
Received: by mail-pa0-f47.google.com with SMTP id fa1so805004pad.34
        for <util-linux@vger.kernel.org>; Tue, 29 Apr 2014 14:05:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
Date: Tue, 29 Apr 2014 22:05:19 +0100
Message-ID: <CAG27Bk2oYs=yEcyxHz8b0xPeMXyLbbbvgX4E4=E93Rv8EpqDxQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] pull: mostly swap command clarifications
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Cc: Sami Kerola <kerolasa@iki.fi>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 27 April 2014 21:05, Sami Kerola <kerolasa@iki.fi> wrote:
> are available in the git repository at:
>
>   git://github.com/kerolasa/lelux-utiliteetit.git 2014wk16

[snip]

>   include/xalloc: ensure arithmetics overflow cannot happen
>   dmesg: move get_boot_time() to lib/timeutils
>   last: fix is_phantom() detection
>   include/c.h: add macro to print definitions as string
>   mkswap, swaplabel: move version number to header
>   mkswap: remove legacy swap structure
>   include/swapheader.h: ensure type sizes
>   swapon: swaps with legacy version label are not supported
>   swapon, swapheader, mkswap: move swap signature to header
>   libsmartcols: remove ununsed assignment
>   lib/timeutils: fix memory leak
>   lib/pager: use names when referring to standard file descriptors

Good evening,

I got rid of the xalloc change, with intention to send some sort of
xrecalloc() later. The 'swapon: swaps with legacy version label are
not supported' patch now uses SWAP_SIGNATURE_SZ instead of magic
number & Bernhard is added as reviewer. Karel, I am not sure if I got
the libsmartcols check right so please ensure the logic is correct.

Corrected versions of the patches are available from my github remote
branch that is using the same name as previous time I sent these. IMHO
the changes are pretty small, so resubmission is not (yet) necessary.
If there's more feedback that might change.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
