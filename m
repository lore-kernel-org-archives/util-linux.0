Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2484 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754650AbaDGIbD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Apr 2014 04:31:03 -0400
Date: Mon, 7 Apr 2014 10:30:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 06/10] kill: leeway deprecation of --pid invocation as
 command name
Message-ID: <20140407083052.GD22126@x2.net.home>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
 <1394397023-7050-6-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394397023-7050-6-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 09, 2014 at 03:30:19PM -0500, Sami Kerola wrote:
> Who knows if anyone is linking or copying kill to a file name 'pid' and
> using --pid option functionality that way, so lets inform these users and
> get rid of command name hack after few releases.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  misc-utils/kill.1 | 5 +++++
>  misc-utils/kill.c | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
> index 50f5cd2..e6c4000 100644
> --- a/misc-utils/kill.1
> +++ b/misc-utils/kill.1
> @@ -88,6 +88,11 @@ Specify that
>  .B kill
>  should only print the process id (pid) of the named processes, and not send any
>  signals.
> +.IP
> +The \-\-pid option functionality is enabled when the command

    The \-\-pid option functionality is *also* enabled when the command

I guess that the --pid is pretty valid an no deprecated at all, the
deprecated is "pid" as argv[0].

I'll fix it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
