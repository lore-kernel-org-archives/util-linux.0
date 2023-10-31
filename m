Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F323BC4332F
	for <util-linux@archiver.kernel.org>; Tue, 31 Oct 2023 17:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345576AbjJaReJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 31 Oct 2023 13:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343574AbjJaReI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 31 Oct 2023 13:34:08 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A895B8F
        for <util-linux@vger.kernel.org>; Tue, 31 Oct 2023 10:34:05 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1698773643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VQqwZryWXZSzLPhJyZ3wi+Ur0HLNushs4CDMYC/hbA0=;
        b=Pcp0mO4Vx1+3z6wI1H3uA3btWWA3J62q1y/oSkT63/uYe6h/2nrxcfhUDKnyL3g3FSu9yi
        yLeRfV/nCP3SI9wlnLh9MrqrM/+S4pPImgte2w3x5y8+W2hudZ8gPab1PZSH08wAEV1pCt
        86uie0+0R2KS9yTXvhi9auDHFfE79GaZmZxZqa+EOR2hC1nL0fLu5HKcAEgutYuUh4rDYe
        uocvZhjbHXwxDoObobOVshJZUooiKqbFqAmGn0umMQsMZIZiOhd8P9hfGJ0IPuGyHU85KW
        yf/Wl2Iv1QGN/Y+XTQVTAw6GRNUw1EjDzB57t53eJ7LV5kqlpL/crOJ9CruRbw==
Date:   Tue, 31 Oct 2023 18:34:03 +0100
From:   Dragan Simic <dsimic@manjaro.org>
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     util-linux@vger.kernel.org, kzak@redhat.com, thomas@t-8ch.de
Subject: Re: [PATCH V2] loopdev: report lost loop device file error
In-Reply-To: <20231025203603.48584-1-junxiao.bi@oracle.com>
References: <20231025203603.48584-1-junxiao.bi@oracle.com>
Message-ID: <c90766480ad9ac312a99359599e1029a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2023-10-25 22:36, Junxiao Bi wrote:
> If a /dev/loopX is lost because someone might have removed it by 
> mistake,
> future losetup operations on that loop device will fail.
> For examples, following cmds will fail when loop device file is lost.
> - "losetup -d $loop_device"
> - "losetup -f $file" or "mount $file $dev"
> 
> Since /sysfs still have the loop device intact, detect that and report
> detailed log message to guide user to recover the lost loop device 
> file.
> 
>     # ./losetup -a
>     /dev/loop0: [64512]:19133870 (/tmp/test.img)
>     # rm -rf /dev/loop0
>     # ./losetup -d /dev/loop0
>     /dev/loop0 is lost, run "mknod /dev/loop0 b 7 0" to recover it.
>     lt-losetup: /dev/loop0: detach failed: No such file or directory

Maybe, but just maybe, we shouldn't provide instructions how to fix the 
issue, but just print the major/minor numbers and let the user figure 
out what's going on and how to fix the issue.

> Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
> ---
> v2 <- v1:
>  - Reporting lost loop device file instead of using mknode to recreate
> v1:
> https://www.spinics.net/lists/util-linux-ng/msg17471.html
> 
>  lib/loopdev.c       | 37 ++++++++++++++++++++++++++++++-------
>  sys-utils/losetup.c | 14 +++++---------
>  2 files changed, 35 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/loopdev.c b/lib/loopdev.c
> index dae499f256fa..c8407857972a 100644
> --- a/lib/loopdev.c
> +++ b/lib/loopdev.c
> @@ -279,6 +279,29 @@ static struct path_cxt *loopcxt_get_sysfs(struct
> loopdev_cxt *lc)
>  	return lc->sysfs;
>  }
> 
> +/*
> + * losetup cmds could fail if /dev/loopX is removed by mistake.
> + * This function will detect that and report a detailed error
> + * log to help sysadmin recreate the lost loop device file.
> + */
> +static void loopcxt_scan_lost_device_file(struct loopdev_cxt *lc)
> +{
> +	static int scanned = 0;
> +	dev_t devno;
> +
> +	/*only scan sysfs once for losetup cmd*/
> +	if (!scanned)
> +		scanned = 1;
> +	else
> +		return;
> +	devno = sysfs_devname_to_devno(lc->device);
> +	if (devno <= 0)
> +		return;
> +
> +	fprintf(stderr, "%s is lost, run \"mknod %s b %d %d\" to recover 
> it.\n",
> +			lc->device, lc->device, major(devno), minor(devno));
> +}
> +
>  static int __loopcxt_get_fd(struct loopdev_cxt *lc, mode_t mode)
>  {
>  	int old = -1;
> @@ -304,6 +327,13 @@ static int __loopcxt_get_fd(struct loopdev_cxt
> *lc, mode_t mode)
>  				mode == O_RDONLY ? "ro" :
>  			        mode == O_RDWR ? "rw" : "??"));
> 
> +		/* loop device file not exist. */
> +		if (lc->fd < 0 && errno == ENOENT) {
> +			DBG(CXT, ul_debugobj(lc, "%s doesn't exist.",
> +						lc->device));
> +			loopcxt_scan_lost_device_file(lc);
> +			errno = ENOENT;
> +		}
>  		if (lc->fd < 0 && old >= 0) {
>  			/* restore original on error */
>  			lc->fd = old;
> @@ -416,13 +446,6 @@ static int loopiter_set_device(struct loopdev_cxt
> *lc, const char *device)
>  	    !(lc->iter.flags & LOOPITER_FL_FREE))
>  		return 0;	/* caller does not care about device status */
> 
> -	if (!is_loopdev(lc->device)) {
> -		DBG(ITER, ul_debugobj(&lc->iter, "%s does not exist", lc->device));
> -		return -errno;
> -	}
> -
> -	DBG(ITER, ul_debugobj(&lc->iter, "%s exist", lc->device));
> -
>  	used = loopcxt_get_offset(lc, NULL) == 0;
> 
>  	if ((lc->iter.flags & LOOPITER_FL_USED) && used)
> diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
> index 0ca910ae3347..b45cc2ee8f3c 100644
> --- a/sys-utils/losetup.c
> +++ b/sys-utils/losetup.c
> @@ -653,7 +653,7 @@ static int create_loop(struct loopdev_cxt *lc,
>  		}
> 
>  		/* errors */
> -		errpre = hasdev && loopcxt_get_fd(lc) < 0 ?
> +		errpre = hasdev && lc->fd < 0 ?
>  				 loopcxt_get_device(lc) : file;
>  		warn(_("%s: failed to set up loop device"), errpre);
>  		break;
> @@ -741,8 +741,7 @@ int main(int argc, char **argv)
>  			break;
>  		case 'c':
>  			act = A_SET_CAPACITY;
> -			if (!is_loopdev(optarg) ||
> -			    loopcxt_set_device(&lc, optarg))
> +			if (loopcxt_set_device(&lc, optarg))
>  				err(EXIT_FAILURE, _("%s: failed to use device"),
>  						optarg);
>  			break;
> @@ -754,8 +753,7 @@ int main(int argc, char **argv)
>  			break;
>  		case 'd':
>  			act = A_DELETE;
> -			if (!is_loopdev(optarg) ||
> -			    loopcxt_set_device(&lc, optarg))
> +			if (loopcxt_set_device(&lc, optarg))
>  				err(EXIT_FAILURE, _("%s: failed to use device"),
>  						optarg);
>  			break;
> @@ -883,8 +881,7 @@ int main(int argc, char **argv)
>  		else
>  			act = A_SHOW_ONE;
> 
> -		if (!is_loopdev(argv[optind]) ||
> -		    loopcxt_set_device(&lc, argv[optind]))
> +		if (loopcxt_set_device(&lc, argv[optind]))
>  			err(EXIT_FAILURE, _("%s: failed to use device"),
>  					argv[optind]);
>  		optind++;
> @@ -935,8 +932,7 @@ int main(int argc, char **argv)
>  	case A_DELETE:
>  		res = delete_loop(&lc);
>  		while (optind < argc) {
> -			if (!is_loopdev(argv[optind]) ||
> -			    loopcxt_set_device(&lc, argv[optind]))
> +			if (loopcxt_set_device(&lc, argv[optind]))
>  				warn(_("%s: failed to use device"),
>  						argv[optind]);
>  			optind++;
