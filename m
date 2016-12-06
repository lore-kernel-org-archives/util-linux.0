Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36189 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbcLFOZz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 6 Dec 2016 09:25:55 -0500
Received: by mail-wm0-f49.google.com with SMTP id g23so130563641wme.1
        for <util-linux@vger.kernel.org>; Tue, 06 Dec 2016 06:25:54 -0800 (PST)
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
In-Reply-To: <20161206141822.vdhpf4wyvmjckkli@ws.net.home>
References: <CAKgNAkjtq0kh7X5umw26FQhh_cork1yb_C-gNL4jHZNr7Fz2qA@mail.gmail.com>
 <20161205115129.hvxasynsgszi33tu@ws.net.home> <d94b2af3-fe84-21be-9e41-3b3668729524@gmx.com>
 <20161206141822.vdhpf4wyvmjckkli@ws.net.home>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Tue, 6 Dec 2016 15:25:33 +0100
Message-ID: <CAKgNAkiiAO9iHf1EFc17s1ptSm4jB0fKsmvGzGNS3Xr-P5fAWg@mail.gmail.com>
Subject: Re: Pull request: nsenter(1) fixes
To: Karel Zak <kzak@redhat.com>
Cc: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 6 December 2016 at 15:18, Karel Zak <kzak@redhat.com> wrote:
> On Mon, Dec 05, 2016 at 01:27:11PM -0500, J William Piggott wrote:
>> On 12/05/2016 06:51 AM, Karel Zak wrote:
>> > On Mon, Dec 05, 2016 at 11:25:45AM +0100, Michael Kerrisk (man-pages) wrote:
>> >> I have various fixes to send, but I'll start small, with a couple of
>> >> fixes for nsenter(1).
>> >
>> >  Applied ... but you have removed "See also.. " sentence from
>> >  description of the --user. Would be better to keep there?
>> >
>> >> Is a git pull request compatible with your
>> >> workflow?
>> >
>> >  Sure.
>>
>> Does this apply to all of us? We no longer need to submit patches to the
>> mailing list for peer review?
>
> Well, send patch to the mailing list for review is always good choice,
> and it's definitely wanted for invasive or sensitive things, or if
> you're not sure.
>
> I think for trivial changes where is nothing to discuss it's probably
> good enough to send pull request only.
>
> It's also good idea to keep the latest version of your patches in
> public remote repository (e.g. github) if you expect any additional
> changes after review etc.
>
> Use common sense anyway. It works better than strict rules.
>
> And this is not LKML, this is mailing list where we keep things in
> friendly atmosphere, so don't be afraid to make a bad choice,
> contribute non-perfect solution or ask "stupid" questions...

All sounds good to me. And I realized after William's comment that it
would be good to put any nontrivial patches onto the list. My first
few patches were trivial. The last series was a little more
substantial, though I think fairly obviously correct fixes for the man
pages. Still, I think I should better put such patches onto the list,
in case someone has improvements to suggest.

However, for pure language fixes and such, I'd probably continue to
use pull requests, if that's okay, so as to avoid the hassle of
putting mailed patches together and also to avoid noise on the list.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
