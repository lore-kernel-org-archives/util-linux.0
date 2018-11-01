Return-Path: <SRS0=5PSr=NM=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D95ECDE46
	for <util-linux@archiver.kernel.org>; Thu,  1 Nov 2018 10:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 178E2205F4
	for <util-linux@archiver.kernel.org>; Thu,  1 Nov 2018 10:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178E2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeKATJM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:09:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbeKATJM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Nov 2018 15:09:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F33BD3082DD4;
        Thu,  1 Nov 2018 10:06:53 +0000 (UTC)
Received: from ws.net.home (ovpn-116-43.ams2.redhat.com [10.36.116.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4D6E261C3;
        Thu,  1 Nov 2018 10:06:52 +0000 (UTC)
Date:   Thu, 1 Nov 2018 11:06:50 +0100
From:   Karel Zak <kzak@redhat.com>
To:     justinpopo6@gmail.com
Cc:     util-linux@vger.kernel.org, f.fainelli@gmail.com
Subject: Re: [PATCH] rtcwake: use poweroff if shutdown is not found
Message-ID: <20181101100650.4lqhxt3olycp5gop@ws.net.home>
References: <1541013948-15403-1-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541013948-15403-1-git-send-email-justinpopo6@gmail.com>
User-Agent: NeoMutt/20180716-521-8fffcf
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 01 Nov 2018 10:06:54 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Oct 31, 2018 at 12:25:48PM -0700, justinpopo6@gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> Some systems do not have the shutdown command. Use poweroff as an
> alternative.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> ---
>  include/pathnames.h |  1 +
>  sys-utils/rtcwake.c | 38 +++++++++++++++++++++++++++-----------
>  2 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/include/pathnames.h b/include/pathnames.h
> index 3d5052e..ed8ea33 100644
> --- a/include/pathnames.h
> +++ b/include/pathnames.h
> @@ -53,6 +53,7 @@
>  # define _PATH_LOGIN		"/bin/login"
>  #endif
>  #define _PATH_SHUTDOWN		"/sbin/shutdown"
> +#define _PATH_POWEROFF		"/sbin/poweroff"
>  
>  #define _PATH_TERMCOLORS_DIRNAME "terminal-colors.d"
>  #define _PATH_TERMCOLORS_DIR	"/etc/" _PATH_TERMCOLORS_DIRNAME
> diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
> index b63c646..b79adbe 100644
> --- a/sys-utils/rtcwake.c
> +++ b/sys-utils/rtcwake.c
> @@ -28,6 +28,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <sys/ioctl.h>
> +#include <sys/stat.h>
>  #include <sys/time.h>
>  #include <sys/types.h>
>  #include <termios.h>
> @@ -579,20 +580,35 @@ int main(int argc, char **argv)
>  		break;
>  	case OFF_MODE:
>  	{
> +		struct stat buf;
>  		char *arg[5];
>  		int i = 0;
>  
> -		if (ctl.verbose)
> -			printf(_("suspend mode: off; executing %s\n"),
> -						_PATH_SHUTDOWN);
> -		arg[i++] = _PATH_SHUTDOWN;
> -		arg[i++] = "-h";
> -		arg[i++] = "-P";
> -		arg[i++] = "now";
> -		arg[i]   = NULL;
> -		if (!ctl.dryrun) {
> -			execv(arg[0], arg);
> -			warn(_("failed to execute %s"), _PATH_SHUTDOWN);
> +		if (!stat(_PATH_SHUTDOWN, &buf)) {

 what about   if (access(_PATH_SHUTDOWN, X_OK) == 0) to avoid copy
 unnecessary struct stat from kernel to userspace? ;-)

    Karel

> +			arg[i++] = _PATH_SHUTDOWN;
> +			arg[i++] = "-h";
> +			arg[i++] = "-P";
> +			arg[i++] = "now";
> +			arg[i]   = NULL;
> +		} else if (!stat(_PATH_POWEROFF, &buf)) {
> +			arg[i++] = _PATH_POWEROFF;
> +			arg[i]   = NULL;
> +		} else {
> +			arg[i] 	 = NULL;
> +		}
> +
> +		if (arg[0]) {
> +			if (ctl.verbose)
> +				printf(_("suspend mode: off; executing %s\n"),
> +						arg[0]);
> +			if (!ctl.dryrun) {
> +				execv(arg[0], arg);
> +				warn(_("failed to execute %s"), arg[0]);
> +				rc = EXIT_FAILURE;
> +			}
> +		} else {
> +			/* Failed to find shutdown command */
> +			warn(_("failed to find shutdown command"));
>  			rc = EXIT_FAILURE;
>  		}
>  		break;
> -- 
> 2.7.4
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
