Return-Path: util-linux-owner@vger.kernel.org
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37420 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751121AbaECMpD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 May 2014 08:45:03 -0400
Message-Id: <1399121099.30443.113236621.44458DE1@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 20/21] login-utils/last.1: Improve the typesetting of the
 manual
Date: Sat, 03 May 2014 14:44:59 +0200
In-Reply-To: <1399084359-28425-4-git-send-email-bjarniig@rhi.hi.is>
References: <1399084359-28425-1-git-send-email-bjarniig@rhi.hi.is>
 <1399084359-28425-4-git-send-email-bjarniig@rhi.hi.is>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hello Bjarni,

On Sat, May 3, 2014, at 4:32, Bjarni Ingi Gislason wrote:
>   Add a space character in front of an ellipsis

Hmm.  I find it clearer when the ellipsis is glued to the thing
that it applies to.  But, as a space before it seems to be the
accepted convention, okay.

However, it would be nice if you could make thematic patches:
one patch for each type of change.  For example, one big patch
for *all* man pages (in util-linux) that makes this space-before-
ellipsis change, then one big patch for no-minus-within-options,
and so on.

(A strange effect of this ellipsis is that between the following pair
of "] [" brackets there will be a double space instead of a single one.
Do you see this too?  An if so, would this be a bug or intentional?)

>   A minus is not used in words.  People using UTF-8 and copy-and-paste
> can(?) (may?) use "info", "man --ascii"

No, you cannot require/suggest that people (if they want to copy and
paste from the man-page output) use 'info' instead of 'man', or use an
extra option.  Commands in the output of plain 'man' should be copy-
and-pastable.  People who want to actually print a manual page may
be required to use extra options to get the typesetting right.

But for me, on a terminal in a UTF-8 locale, it makes no difference
whether a man page contains \-\-long-option or --long-option, all
those dashes render to  0x2d.  So copy-and-paste will work fine.

By the way, what do you use to look at a typeset version of a man
page?  For the first time in my life I've looked at a virtual printout
with 'man -Tps login-utils/last.1 >last.ps; evince last.ps', and I must
say that I find the rendering of --long-option more readable than of
\-\-long-option.  But as I won't ever use this, either way is fine with me.

> -.RI [ username ...]
> -.RI [ tty ...]
> +.RI [ username " ...]
> +.RI [ tty " ...]

Hm.  An unpaired quotation mark I find ugly.
Better do "username " or " ...]" instead.


Benno

-- 
http://www.fastmail.fm - Or how I learned to stop worrying and
                          love email again

