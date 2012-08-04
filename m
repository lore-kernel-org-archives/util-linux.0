Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vc0-f174.google.com ([209.85.220.174]:51947 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277Ab2HDP57 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 4 Aug 2012 11:57:59 -0400
Received: by vcbfk26 with SMTP id fk26so1600710vcb.19
        for <util-linux@vger.kernel.org>; Sat, 04 Aug 2012 08:57:58 -0700 (PDT)
Date: Sat, 4 Aug 2012 11:57:55 -0400
From: Dave Reisner <d@falconindy.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: util-linux@vger.kernel.org
Subject: Re: suggestion to avoid erroneous lines in findmnt/lslocks/...
Message-ID: <20120804155755.GJ529@rampage>
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
> 
> The essential issue fixed there is that control chars in a path will be
> converted to '?' (this works in all locales), and doing so will mean
> '\n' for example is not output. You could even consider this a potential
> security improvement so that arbitrary users couldn't influence the
> output of these commands for all users.
> 
> I suggest using the simple inplace replacement function from above.

Why replace with a bogus character when you could instead use an octal
or hex escape? Wouldn't this still address the underlying problem?
Munging the content of a string could break a script consuming the
output with no way for the script to recover.

