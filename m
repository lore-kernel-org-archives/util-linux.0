Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35423 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbdFGRJy (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 7 Jun 2017 13:09:54 -0400
Received: by mail-oi0-f68.google.com with SMTP id v74so1210892oie.2
        for <util-linux@vger.kernel.org>; Wed, 07 Jun 2017 10:09:53 -0700 (PDT)
Subject: Re: [PATCH 6/6] misc: fix some warnings
To: kerolasa@gmail.com, J William Piggott <elseifthen@gmx.com>
Cc: Ruediger Meier <sweet_f_a@gmx.de>,
        util-linux <util-linux@vger.kernel.org>
References: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
 <1496279320-14541-7-git-send-email-sweet_f_a@gmx.de>
 <0035d164-75ac-f892-2cbe-0fb8184116cb@gmx.com>
 <201706061010.07911.sweet_f_a@gmx.de>
 <de2ea265-ed30-8493-7267-a113b9140a5d@gmx.com>
 <42e92093-bed4-daa0-e2cd-f90205e17f8b@gmx.com>
 <CAG27Bk1W2wbSFoAV70EpWT-2USvmuHV_muC2DODr8ALODTS_ww@mail.gmail.com>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <5938335F.9090108@gmail.com>
Date: Wed, 7 Jun 2017 12:09:51 -0500
MIME-Version: 1.0
In-Reply-To: <CAG27Bk1W2wbSFoAV70EpWT-2USvmuHV_muC2DODr8ALODTS_ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sami Kerola wrote:
> On 6 June 2017 at 20:17, J William Piggott <elseifthen@gmx.com> wrote:

>> I forgot to mention, the line in question exceeds 80 columns and should
>> be split again (the line changed in last.c wraps now also).
>
> I would say 80 columns is preferred, but we should not be too strict with it.
> Sometimes code does look better when wider, and that's fine.
>
> And the spaces vs tab. Yep, we should prefer tabs but sometimes accidents
> happen. Calling these 'wrong' is too strong. This is yet another preference
> thing, and if someone notices during review spaces where there should be
> tabs then that's a good review commend and should be fixed. But I would
> not go so far that existing whitespaces ought to be fixed without a change
> to code line where they are.
>
> util-linux $ for i in $(find . -name '*.c'); do unexpand $i > $i- ; mv
> $i- $i; done
> util-linux $ git diff --stat

Just to throw in my two cents, tabs in source code cause problems unless 
you have a comment like:

// vim: noai:ts=8:sw=8

and the emacs equivalent.

I spend a lot of effort aligning source code to make it readable. 
Research from the 1980s and early 1990s indicated the best levels of 
indentations for readability and comprehension of source code is between 2 
and 4 spaces.  I personally use 3 characters.

Using tabs with different settings destroys that readability.

IMO, embedded tabs in source code add nothing but problems.  Editors can 
easily substitute the correct number of spaces when you hit the tab key 
and spaces allow the reader to always see the code as the author intended.

However, it is your project and your rules.  I am not asking for a change.

   -- Bruce Dubbs
      linuxfromscratch.org

