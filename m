Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59348 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbcHHKWO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Aug 2016 06:22:14 -0400
Date: Mon, 8 Aug 2016 12:22:11 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] uuidd: require use of --socket-activation when run
 as systemd service
Message-ID: <20160808102211.ijejkvnutrbrz2xp@ws.net.home>
References: <20160803224158.23657-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160803224158.23657-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 03, 2016 at 11:41:57PM +0100, Sami Kerola wrote:
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  misc-utils/uuidd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
> index a3fe830..77c967d 100644
> --- a/misc-utils/uuidd.c
> +++ b/misc-utils/uuidd.c
> @@ -651,6 +651,13 @@ int main(int argc, char **argv)
>  	else if (pidfile_path_param)
>  		pidfile_path = pidfile_path_param;
>  
> +#ifdef HAVE_LIBSYSTEMD
> +	if (getppid() == 1 && 0 < sd_booted() &&
> +	    (!uuidd_cxt.no_sock || !uuidd_cxt.no_fork || !no_pid))
> +		errx(EXIT_FAILURE,  _("cannot run as systemd service "
> +				      "without --socket-activation"));
> +#endif

 Why? 
 
 I do not test it, but I guess --socket-activation is always an
 optional way. It's enabled by default in systemd unit files, but I
 guess for some test purpose you can use old way to start uuid
 independently on your initd. Right?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
