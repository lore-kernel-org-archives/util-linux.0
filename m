Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37292 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbbFGUmA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jun 2015 16:42:00 -0400
Received: by wifx6 with SMTP id x6so66732786wif.0
        for <util-linux@vger.kernel.org>; Sun, 07 Jun 2015 13:41:58 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20150602124803.GL7285@ws.net.home>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
	<20150602124803.GL7285@ws.net.home>
Date: Sun, 7 Jun 2015 21:41:58 +0100
Message-ID: <CAG27Bk1jXtb4CQ1RUwqbW_NiRyBvouwUcJ=WF21y-C7Op+fC=w@mail.gmail.com>
Subject: Re: [PATCH 00/13] pull: rtcwake changes
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2 June 2015 at 13:48, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Feb 22, 2015 at 02:42:06PM +0000, Sami Kerola wrote:
>>  git://github.com/kerolasa/lelux-utiliteetit.git rtcwake
>
> I have reviewed
>
>    https://github.com/kerolasa/lelux-utiliteetit/commits/rtcwake2
>
> and commented by github line notes.

Cheers. I left the rtcwake2 untouched, so that comments can be read
until final merge.

Some comments to comment.

> https://github.com/kerolasa/lelux-utiliteetit/commit/0358a2cec1f55c4a723cb55c4da7ea201d2acb68#diff-40ed35508632e222c29a58eba03a4271L374

Type is changed, but I left the while loop as is. It looks nicer to
me. Besides the get_mode() changes later in patch set again.

> https://github.com/kerolasa/lelux-utiliteetit/commit/0358a2cec1f55c4a723cb55c4da7ea201d2acb68#diff-40ed35508632e222c29a58eba03a4271L510

Well, that was dumb issue. Thank you pointing it out.

> https://github.com/kerolasa/lelux-utiliteetit/commit/cca324d3360535f0d990f7e696ebfd093b725c9c#diff-40ed35508632e222c29a58eba03a4271L317

skip_fline() is added to strutils.h and used the way as requested.

> https://github.com/kerolasa/lelux-utiliteetit/commit/d8c827a711e6e2d34ce01dc460d98c4a3759e04a#diff-40ed35508632e222c29a58eba03a4271L501

So do I.

> https://github.com/kerolasa/lelux-utiliteetit/commit/81f7e2a6fc5870ebfcb078e0973b0d9a57cae205#diff-40ed35508632e222c29a58eba03a4271R390

Done a bit differently with xstrdup(), so that I there's always an
allocation and free()'ing is simple.

> https://github.com/kerolasa/lelux-utiliteetit/commit/b9d49884a250e33c55f92e47d0e1b72e33598998#diff-40ed35508632e222c29a58eba03a4271L601

The strv.h is now used. I hope the code is more elegant, but to be
honest improvement might not be quite as nice as hoped. Notice that
the ctl->possible_modes is populated only when --list-modes and --mode
are in use, so I don't see any point running get_sys_power_states() at
early of execution.

BTW the new rtcwake3 has new commit. Just a simple fix.

https://github.com/kerolasa/lelux-utiliteetit/commit/a08b7936598fdc462c516331c4b91d331d7508ff
rtcwake: fix valgrind warning

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
