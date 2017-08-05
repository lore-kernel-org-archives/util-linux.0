Return-Path: kerolasa@gmail.com
Sender: Sami Kerola <kerolasa@gmail.com>
Date: Sat, 5 Aug 2017 17:33:16 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/9] chfn, chsh: merge auth.h, islocal.h and libuser.h
 to ch-common.h
In-Reply-To: <20170801092726.jyajaltu5mpihjgo@ws.net.home>
Message-ID: <alpine.LNX.2.20.1708051732280.4995@imuri>
References: <20170731195508.11661-1-kerolasa@iki.fi> <20170731195508.11661-2-kerolasa@iki.fi> <20170801092726.jyajaltu5mpihjgo@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Tue, 1 Aug 2017, Karel Zak wrote:
> Frankly, I'm not sure if this patch improves readability of the code.
> Now we have to ways (pam and libuser) and both is pretty separated by
> .c and .h files. Not sure if merge it makes it better.

Fair enough. This change is dropped from my 2017wk30 branch.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
