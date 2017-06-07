Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:56800 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753143AbdFGXjc (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 7 Jun 2017 19:39:32 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Subject: Re: [PATCH 6/6] misc: fix some warnings
Date: Thu, 8 Jun 2017 01:39:23 +0200
Cc: kerolasa@gmail.com, J William Piggott <elseifthen@gmx.com>,
        "util-linux" <util-linux@vger.kernel.org>
References: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de> <CAG27Bk1W2wbSFoAV70EpWT-2USvmuHV_muC2DODr8ALODTS_ww@mail.gmail.com> <5938335F.9090108@gmail.com>
In-Reply-To: <5938335F.9090108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201706080139.23893.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 07 June 2017, Bruce Dubbs wrote:
> Sami Kerola wrote:
> > On 6 June 2017 at 20:17, J William Piggott <elseifthen@gmx.com> 
wrote:
> >> I forgot to mention, the line in question exceeds 80 columns and
> >> should be split again (the line changed in last.c wraps now also).
> >
> > I would say 80 columns is preferred, but we should not be too
> > strict with it. Sometimes code does look better when wider, and
> > that's fine.
> >
> > And the spaces vs tab. Yep, we should prefer tabs but sometimes
> > accidents happen. Calling these 'wrong' is too strong. This is yet
> > another preference thing, and if someone notices during review
> > spaces where there should be tabs then that's a good review commend
> > and should be fixed. But I would not go so far that existing
> > whitespaces ought to be fixed without a change to code line where
> > they are.
> >
> > util-linux $ for i in $(find . -name '*.c'); do unexpand $i > $i- ;
> > mv $i- $i; done
> > util-linux $ git diff --stat
>
> Just to throw in my two cents, tabs in source code cause problems
> unless you have a comment like:
>
> // vim: noai:ts=8:sw=8
>
> and the emacs equivalent.
>
> I spend a lot of effort aligning source code to make it readable.
> Research from the 1980s and early 1990s indicated the best levels of
> indentations for readability and comprehension of source code is
> between 2 and 4 spaces.  I personally use 3 characters.
>
> Using tabs with different settings destroys that readability.
>
> IMO, embedded tabs in source code add nothing but problems.  Editors
> can easily substitute the correct number of spaces when you hit the
> tab key and spaces allow the reader to always see the code as the
> author intended.

IMO it is no problem to write nice looking code if you don't "mix" tabs 
and spaces. Distinguish between indentation and alignment.

So I use these rules which do not conflict with kernel coding style and 
tab-width=8:

  1. tabs for indentation level only (same as the previous line)
  2. spaces for alignment only

That's why in this particular case I've made one tab for the indentation 
and 14 spaces for the nice looking alignment. Though usually alignment 
is nonsense anyways, so I could have better just used one more 
indentation (one tab) instead of that 14 spaces. But I would never use 
1 tab and 6 spaces to let look like 14 spaces. This would have also 
satisfied the 80 char limit without adding another ugly line break.

BTW we have many lines in the our code which are more than 80 chars when 
assuming tab-width=8. That's why I take it as de-facto standard to 
count the line length assuming tab-width=4.


> However, it is your project and your rules.  I am not asking for a
> change.
>
>    -- Bruce Dubbs
>       linuxfromscratch.org
>
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


