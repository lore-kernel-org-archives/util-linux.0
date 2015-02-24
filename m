Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50423 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbbBXNAO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Feb 2015 08:00:14 -0500
Date: Tue, 24 Feb 2015 14:00:02 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 09/13] rtcwake: do not overwrite device name
Message-ID: <20150224130002.GR19430@ws.net.home>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi>
 <1424616139-638-10-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424616139-638-10-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 22, 2015 at 02:42:15PM +0000, Sami Kerola wrote:
> This improves error messaging, and allows freeing path to device when it
> is not needed.
> 
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
> ---
>  sys-utils/rtcwake.c | 44 +++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
> index f951c9c..7f1e351 100644
> --- a/sys-utils/rtcwake.c
> +++ b/sys-utils/rtcwake.c
> @@ -49,7 +49,7 @@
>  
>  #define RTC_PATH		"/sys/class/rtc/%s/device/power/wakeup"

This is really bad name, what about SYS_WAKEUP_PATH_TEMPLATE ?

> +static int open_dev_rtc(const char *devname)
> +{
> +	int fd;
> +	char *devpath;
> +	size_t len = strlen(devname);
> +
> +	devpath = xmalloc(sizeof "/dev/" + len);
> +	memcpy(devpath, "/dev/", sizeof "/dev/");
> +	memcpy(devpath + strlen("/dev/"), devname, len + 1);

 if (startswith(devname, "/dev"))
    devpath = devname;
 else
    xasprintf(&devpath, "/dev/%s", devname);  

> +#ifdef O_CLOEXEC
> +	fd = open(devpath, O_RDONLY | O_CLOEXEC);
> +#else
> +	fd = open(devpath, O_RDONLY);
> +#endif

 we use O_CLOEXEC everywhere, #ifdef is unecessary

> +	if (fd < 0)
> +		err(EXIT_FAILURE, _("%s: unable to find device"), devpath);

 if (devname != devpath)
    free(devpath);

> +	free(devpath);
> +	return fd;
> +}

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
