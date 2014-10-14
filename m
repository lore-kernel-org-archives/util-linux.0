Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f170.google.com ([209.85.217.170]:40958 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbaJNJvc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 14 Oct 2014 05:51:32 -0400
Received: by mail-lb0-f170.google.com with SMTP id u10so7911968lbd.15
        for <util-linux@vger.kernel.org>; Tue, 14 Oct 2014 02:51:30 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20141014090311.GM8057@x2.net.home>
References: <5426D4C2.4060403@gmx.com>
	<5426D7C0.50108@gmx.com>
	<alpine.LNX.2.03.1409281829450.8884@iki.fi>
	<54298D46.6010101@gmx.com>
	<20141014090311.GM8057@x2.net.home>
Date: Tue, 14 Oct 2014 10:51:30 +0100
Message-ID: <CAG27Bk3x9YsB0sK+3ftPG4P_i8mK-en4BB=WoTjvPfpLvOLmOA@mail.gmail.com>
Subject: Re: [PATCH 1/7] hwclock: hctosys drift compensation II
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: JWP <elseifthen@gmx.com>, util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 14 October 2014 10:03, Karel Zak <kzak@redhat.com> wrote:
> Maybe it would be better to think about whole code refactoring as it's
> horrible code. It's probably last so horrible code in util-linux.

Along with more(1). I started to look this refactoring task, and it
seems reimplementation would be best option. Does someone fancy a
programming challenge?

Few disk utils, cramfs, bfs, and minix related, could also be improved
or marked deprecated. I am hoping for later.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
