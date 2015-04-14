Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38750 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753664AbbDNKEk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Apr 2015 06:04:40 -0400
Date: Tue, 14 Apr 2015 12:04:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/7] logger tests do not need /dev/log but socat
Message-ID: <20150414100438.GV3923@ws.net.home>
References: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 13, 2015 at 02:01:46PM +0200, Ruediger Meier wrote:
> Now we require socat for logger tests. We should NOT add fallback to
> netcat-like tools. I have tried this but there are too many different
> and broken netcat versions out there.

I think dependence on socat in the tests is fine, it's unnecessary to
have fallbacks for everything. It's test suite (mostly for developers)
not just some random environment on some random system.

> Ruediger Meier (7):
>   logger: --stderr and --no-act turn "auto-errors" on
>   tests: simplify common logger options
>   tests: logger with socat device
>   tests: logger, validate written socket data
>   tests: logger/errors does not use --no-act
>   tests: add subtests for invalid logger devive
>   travis: install socat

Applied, thanks! It's perfect that we really test sockets now
(--stderr --no-act is poor man solution:-).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
