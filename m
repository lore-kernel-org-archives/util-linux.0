Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751826AbdB1Nr4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 28 Feb 2017 08:47:56 -0500
Date: Tue, 28 Feb 2017 14:37:13 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [V2 0/4] hwclock: remove date(1)
Message-ID: <20170228133713.377klbjm44roizx6@ws.net.home>
References: <ee9e12b4-a921-b47e-975d-53a5b8575361@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ee9e12b4-a921-b47e-975d-53a5b8575361@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Feb 25, 2017 at 01:25:37PM -0500, J William Piggott wrote:
> 
> * The last commit/patch adds hwclock-date.c

Seems better than the previous attempt.

>    I added this file in case testers do not have 'bison' installed. It
>    may, or may not, need to be tracked depending on how it is to be
>    maintained. The 'c' file probably should be included in the
>    distributed source archive to avoid the bison dependency.  Karel, I
>    don't know if you want to create a separate clean and build target
>    for hwclock-date.c, or how you want to handle this. So, if you don't
>    mind, I'll leave this detail to you.

Yes, it's good idea to have .c files in the distribution tarball, but
I'd like to avoid generated files in the git repository. I'll try to
play with it (autotools) to generate .y to .c on the fly if missing.

Do you want to keep the .y file sync with gnulib and minimize number
of our local changes, or is it so stable area that we don't have to
care about it? ... because I don't like the coding style and  the
debug stuff. If the overhead to maintain the file locally will be
minimal than we can probably clean up it :-)

I guess it will be possible to move it to lib/parse-datetime.c and use
it on another places in util-linux (instead of our minimalistic
parse_datetime()), right?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
