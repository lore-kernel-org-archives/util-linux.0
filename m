Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Tue, 15 Aug 2017 19:23:39 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] isosize: iterate over all arguments even when something
 fails
In-Reply-To: <20170814090821.qxqr4ill4ihtjlyc@ws.net.home>
Message-ID: <alpine.LNX.2.20.1708151913490.1230@imuri>
References: <20170812083208.1208-1-kerolasa@iki.fi> <20170814090821.qxqr4ill4ihtjlyc@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Mon, 14 Aug 2017, Karel Zak wrote:
> Seems like overkill, why we need so specific information? I guess it
> would be enough
> 
>     0 - EXIT_SUCCESS
>     1 - EXIT_FAILURE
>    64 - EXIT_SOMEOK  (already used for mount, lsblk, kill, ...)

I kept small overkill and used two different return values: 64 for some 
ok, and 32 all failed.

https://github.com/kerolasa/lelux-utiliteetit/commit/dea7a778beb6b043a889904d43b2b2b561814326

That is in branch: 2017wk32

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
