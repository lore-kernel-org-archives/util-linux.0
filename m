Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35087 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbcLEL46 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 5 Dec 2016 06:56:58 -0500
Received: by mail-wm0-f51.google.com with SMTP id a197so93321557wmd.0
        for <util-linux@vger.kernel.org>; Mon, 05 Dec 2016 03:56:57 -0800 (PST)
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
In-Reply-To: <20161205115129.hvxasynsgszi33tu@ws.net.home>
References: <CAKgNAkjtq0kh7X5umw26FQhh_cork1yb_C-gNL4jHZNr7Fz2qA@mail.gmail.com>
 <20161205115129.hvxasynsgszi33tu@ws.net.home>
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date: Mon, 5 Dec 2016 12:56:36 +0100
Message-ID: <CAKgNAkgLVYfiroRtGbP48uFps8=EGtAhdt5iLsmVdX0zsRAJMw@mail.gmail.com>
Subject: Re: Pull request: nsenter(1) fixes
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Karel,

On 5 December 2016 at 12:51, Karel Zak <kzak@redhat.com> wrote:
> On Mon, Dec 05, 2016 at 11:25:45AM +0100, Michael Kerrisk (man-pages) wrote:
>> I have various fixes to send, but I'll start small, with a couple of
>> fixes for nsenter(1).
>
>  Applied ... but you have removed "See also.. " sentence from
>  description of the --user. Would be better to keep there?

My apologies. That was a blunder. I can send you a patch, or do you
want to revert that deletion manually. Let me know which you prefer.

>> Is a git pull request compatible with your
>> workflow?
>
>  Sure.

Great.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
