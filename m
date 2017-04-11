Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:49771 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752534AbdDKTIO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 11 Apr 2017 15:08:14 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: J William Piggott <elseifthen@gmx.com>
Subject: Re: [PATCH] hwclock: fix non-linux build
Date: Tue, 11 Apr 2017 21:07:59 +0200
Cc: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
References: <1491897955-22436-1-git-send-email-sweet_f_a@gmx.de> <64fc96d4-3e5f-ee6d-2ab9-bc90c8f8c5e9@gmx.com>
In-Reply-To: <64fc96d4-3e5f-ee6d-2ab9-bc90c8f8c5e9@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <201704112107.59250.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 11 April 2017, J William Piggott wrote:
> On 04/11/2017 04:05 AM, Ruediger Meier wrote:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> >
> > There was one missing ifdef since 336f7c5f.
>
> They were both in that 'if' test before 336f7c5f:
>
> -       if (!(show | set | systohc | hctosys | systz | adjust |
> getepoch -             | setepoch | predict | compare | get))
> -               show = 1;       /* default to show */
>
> But they were defined for all arches then:
>
> -       /* Set option defaults */
> -       show = set = systohc = hctosys = systz = adjust = noadjfile =
> predict = -           compare = get = update = FALSE;
> -       getepoch = setepoch = utc = local_opt = directisa = testing =
> debug = FALSE;
>
>
> I think the old way was a cleaner solution, so in
> sys-utils/hwclock.h:35:
>
> - #ifdef __linux__
>   		getepoch:1,
>   		setepoch:1,
> - #endif
>
> Should work? I do not have a way to test it.

Yes, I've had also thought about this but was not sure and also too lazy 
to check possible side effects. Somehow I think we should either remove 
all ifdefs (__linux__, __alpha__, HAVE_LIBAUDIT) from that struct or 
none.

cu,
Rudi
