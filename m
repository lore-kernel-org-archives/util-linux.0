Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f46.google.com ([209.85.216.46]:59541 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab2JNWKr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 18:10:47 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so820018qad.19
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 15:10:46 -0700 (PDT)
Date: Sun, 14 Oct 2012 18:10:44 -0400
From: Dave Reisner <d@falconindy.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/19] sd-daemon: fix cppcheck warnings
Message-ID: <20121014221044.GR533@rampage>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
 <1350246070-10544-8-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350246070-10544-8-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Oct 14, 2012 at 09:20:58PM +0100, Sami Kerola wrote:
> [misc-utils/sd-daemon.c:91]: (style) Checking if unsigned variable 'l' is \
> less than zero.
> [misc-utils/sd-daemon.c:254]: (warning) Comparison of a boolean \
> expression with an integer.
> [misc-utils/sd-daemon.c:363]: (style) Checking if unsigned variable \
> 'length' is less than zero.
> [misc-utils/sd-daemon.c:366]: (style) Checking if unsigned variable \
> 'length' is less than zero.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  misc-utils/sd-daemon.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/misc-utils/sd-daemon.c b/misc-utils/sd-daemon.c
> index 763e079..21399e2 100644
> --- a/misc-utils/sd-daemon.c
> +++ b/misc-utils/sd-daemon.c

This file comes directly from the systemd tree. I think it'd be better
to submit the fix there first.

Either way, there's whitespace errors in this patch (tabs rather than
spaces).

> @@ -88,7 +88,7 @@ _sd_export_ int sd_listen_fds(int unset_environment) {
>                  goto finish;
>          }
>  
> -        if (!p || *p || l <= 0) {
> +	if (!p || *p || l == 0) {
>                  r = -EINVAL;
>                  goto finish;
>          }
> @@ -251,7 +251,7 @@ static int sd_is_socket_internal(int fd, int type, int listening) {
>                  if (l != sizeof(accepting))
>                          return -EINVAL;
>  
> -                if (!accepting != !listening)
> +		if ((!accepting) != (!listening))
>                          return 0;
>          }
>  
> @@ -360,10 +360,10 @@ _sd_export_ int sd_is_socket_unix(int fd, int type, int listening, const char *p
>                  return 0;
>  
>          if (path) {
> -                if (length <= 0)
> +		if (length == 0)
>                          length = strlen(path);
>  
> -                if (length <= 0)
> +		if (length == 0)
>                          /* Unnamed socket */
>                          return l == offsetof(struct sockaddr_un, sun_path);
>  
> -- 
> 1.7.12.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
