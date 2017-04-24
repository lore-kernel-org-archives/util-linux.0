Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166957AbdDXKKp (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 24 Apr 2017 06:10:45 -0400
Date: Mon, 24 Apr 2017 12:10:40 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 03/10] docs: raw devices are deprecated
Message-ID: <20170424101040.snryxu4sndqtyzza@ws.net.home>
References: <20170423205821.7444-1-kerolasa@iki.fi>
 <20170423205821.7444-4-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170423205821.7444-4-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 23, 2017 at 09:58:14PM +0100, Sami Kerola wrote:
> Tell in manual page that one should use open(2) O_DIRECT flag rather than
> raw device.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  disk-utils/raw.8 | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/disk-utils/raw.8 b/disk-utils/raw.8
> index 717f4ef1b..5d04aa226 100644
> --- a/disk-utils/raw.8
> +++ b/disk-utils/raw.8
> @@ -88,6 +88,13 @@ device buffer cache.  If you use raw I/O to overwrite data already in
>  the buffer cache, the buffer cache will no longer correspond to the
>  contents of the actual storage device underneath.  This is deliberate,
>  but is regarded either a bug or a feature depending on who you ask!
> +.SH NOTES
> +Kernel developers consider raw driver deprecated.  Applications should

Maybe you want to see "git log disk-utils/raw.8", raw devices are not
deprecated any more. See kernel commit abd4aa5a97ebc0efb9a7fbc98ef0bcf39266fadf.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
