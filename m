Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750899AbdAJQgj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 10 Jan 2017 11:36:39 -0500
Date: Tue, 10 Jan 2017 17:36:37 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] If mtab support is disabled, disable ro/rw mtab checks
Message-ID: <20170110163637.e2g3fd4gnfobjs7r@ws.net.home>
References: <4d702326-5d60-8430-73a9-2e25dac6e49e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4d702326-5d60-8430-73a9-2e25dac6e49e@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 10, 2017 at 01:54:17PM +0100, Stanislav Brabec wrote:
> Commit f9906424 introduced a check that should prevent different information in
> mtab and /proc/mounts. The check can require significant amount of time, and for
> systems without mtab support it has no sense.
> 
> Execute this code only on systems with mtab.
> 
> When a systems with large number of nodes (thousands) mount the filesystems
> simultaneously, the time required for serialization causes the utimensat() to
> take a large amount of time (tens of minutes) when a large number of nodes are
> simultaneously updating the timestamp.
> 
> Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
> ---
>  libmount/src/context_mount.c | 2 ++
>  1 file changed, 2 insertions(+)

Ah, nice catch! Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
