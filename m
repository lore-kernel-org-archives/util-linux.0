Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40481 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753817Ab2HFIPh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 Aug 2012 04:15:37 -0400
Date: Mon, 6 Aug 2012 10:15:33 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: util-linux@vger.kernel.org
Subject: Re: suggestion to avoid erroneous lines in findmnt/lslocks/...
Message-ID: <20120806081533.GA24621@x2.net.home>
References: <501D42D2.6050904@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <501D42D2.6050904@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Aug 04, 2012 at 04:42:10PM +0100, Pádraig Brady wrote:
> There was a recent change in df in coreutils to sanitize output of paths:
> 
> http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=commitdiff;h=3ed70fd

 Thanks!

> The essential issue fixed there is that control chars in a path will be
> converted to '?' (this works in all locales), and doing so will mean
> '\n' for example is not output. You could even consider this a potential
> security improvement so that arbitrary users couldn't influence the
> output of these commands for all users.
> 
> I suggest using the simple inplace replacement function from above.

All our new utils (based on lib/tt.c) already uses hex encoding for
ascii non-printable when export mode (e.g. findmnt -P)
or blank chars when raw mode (e.g. findmnt -r) is specified.

The default output does not escape problematic chars :-(

I'll fix it to use iscntrl() and \x?? hex (to be consistent our
another outputs).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
