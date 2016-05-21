Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34660 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbcEURQl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 21 May 2016 13:16:41 -0400
Received: by mail-oi0-f52.google.com with SMTP id b65so78995204oia.1
        for <util-linux@vger.kernel.org>; Sat, 21 May 2016 10:16:40 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CAG27Bk3r-EGNqDadbbcM52DQH0yiv2BYTDnHzDKHZfqNoxCuUA@mail.gmail.com>
References: <201603081437.31966.sweet_f_a@gmx.de>
	<CAG27Bk02Yx5fxpV0sWGaLF7W4jSVOcKwGXWQBBQ7DLT48kZF8w@mail.gmail.com>
	<201603082359.43056.sweet_f_a@gmx.de>
	<20160520102731.schhho5sl6k7cwq3@ws.net.home>
	<CAG27Bk3r-EGNqDadbbcM52DQH0yiv2BYTDnHzDKHZfqNoxCuUA@mail.gmail.com>
Date: Sat, 21 May 2016 18:16:35 +0100
Message-ID: <CAG27Bk1FF3Na3=RxwUBXBeMsKp3=8KuHK72PmqtM_5qGXPYUDQ@mail.gmail.com>
Subject: Re: cal: bug on FreeBSD
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: =?UTF-8?Q?R=C3=BCdiger_Meier?= <sweet_f_a@gmx.de>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 21 May 2016 at 09:08, Sami Kerola <kerolasa@iki.fi> wrote:
> +#ifdef BSD_TPUTS
> +# unset BSD_TPUTS
> +#endif

There are couple problems with this change. First of all the BSD_TPUTS
is a complier directive that should be unset to avoid the problems when
compiling ncurses. Fidling after the ncurses compilation with this define
makes no difference what so ever. Secondly there weren't enough
swearing in the commit message.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
