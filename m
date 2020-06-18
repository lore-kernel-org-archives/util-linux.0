Return-Path: <SRS0=vf6E=77=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650EEC433DF
	for <util-linux@archiver.kernel.org>; Thu, 18 Jun 2020 10:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7F121548
	for <util-linux@archiver.kernel.org>; Thu, 18 Jun 2020 10:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZEqv8fP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgFRKGj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:06:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23423 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727854AbgFRKGh (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 18 Jun 2020 06:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592474796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yfjtke/N/6YleOE8y1VVu2SAnEhcUOY4RdYtFxAzXZ8=;
        b=HZEqv8fPLKHUZkYHKezYYpOG5zqCtIqMGu7qN5oyH8qcA/wGykeFDEkjkwcXP/KupQImdv
        DvWppHRT5VN195uA9fnzTY8HCPtnDWwCYCwJGvRaltbfvvzXV8877Z9GFoVTsffPT51bNb
        TYPs6nIw0E934RMAdJk1EclBvlENUGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-mRPmNBc5PSyKiSJKDkRqNw-1; Thu, 18 Jun 2020 06:06:31 -0400
X-MC-Unique: mRPmNBc5PSyKiSJKDkRqNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD9E318FF661
        for <util-linux@vger.kernel.org>; Thu, 18 Jun 2020 10:06:30 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E731C5DA74;
        Thu, 18 Jun 2020 10:06:28 +0000 (UTC)
Date:   Thu, 18 Jun 2020 12:06:26 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] blkdiscard: Refuse to proceed if signatures are found
Message-ID: <20200618100626.f5uyuxomfhbnhibn@ws.net.home>
References: <20200618092916.12191-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618092916.12191-1-lczerner@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jun 18, 2020 at 11:29:16AM +0200, Lukas Czerner wrote:
> With this commit blkdiscard will check for existing signatures on the
> device and refuse to continue if any are found unless the operation is
> forced with the -f option.

Good idea.

> +/*
> + * Check existing signature on the open fd
> + * Returns	0  if no signature was found
> + * 		1  if a signature was found

this is not true, 0 means detected, 1 not found

> + * 		<0 on error
> + */
> +static int device_empty(int fd, char *path)

This is difficult for to read, at first glance it seems according
to function name that 1 means "yes, it's empty".
      
Maybe rename it to probe_device().

> +{
> +	const char *type;
> +	blkid_probe pr = NULL;
> +	int ret = -1;
> +
> +	pr = blkid_new_probe();
> +	if (!pr || blkid_probe_set_device(pr, fd, 0, 0))
> +		return ret;
> +
> +	blkid_probe_enable_superblocks(pr, TRUE);
> +	blkid_probe_enable_partitions(pr, TRUE);
> +
> +	ret = blkid_do_fullprobe(pr);
> +	if (ret)
> +		return ret;

yes, blkid_do_fullprobe() returns: 0 on success, 1 if nothing is detected or -1 on case of error.

> +
> +	if (!blkid_probe_lookup_value(pr, "TYPE", &type, NULL)) {
> +		warnx("%s contains existing file system (%s).",path ,type);
> +	} else if (!blkid_probe_lookup_value(pr, "PTTYPE", &type, NULL)) {
> +		warnx("%s contains existing partition (%s).",path ,type);
> +	} else {
> +		warnx("%s contains existing signature.", path);
> +	}
> +
> +	blkid_free_probe(pr);
> +	return ret;

This is always 0.

> +}
>  
>  int main(int argc, char **argv)
>  {
>  	char *path;
> -	int c, fd, verbose = 0, secsize, force = 0;
> +	int c, fd, ret, verbose = 0, secsize, force = 0;
>  	uint64_t end, blksize, step, range[2], stats[2];
>  	struct stat sb;
>  	struct timeval now, last;
> @@ -184,7 +219,7 @@ int main(int argc, char **argv)
>  		errtryhelp(EXIT_FAILURE);
>  	}
>  
> -	fd = open(path, O_WRONLY | (force ? 0 : O_EXCL));
> +	fd = open(path, O_RDWR | (force ? 0 : O_EXCL));
>  	if (fd < 0)
>  		err(EXIT_FAILURE, _("cannot open %s"), path);
>  
> @@ -217,6 +252,21 @@ int main(int argc, char **argv)
>  		errx(EXIT_FAILURE, _("%s: length %" PRIu64 " is not aligned "
>  			 "to sector size %i"), path, range[1], secsize);
>  
> +	 /* Check for existing signatures on the device */
> +	if ((ret = device_empty(fd, path)) == 0) {

 What about:

 switch (probe_device(fd, path)) {
 case 0: /* signature detected */
> +		/*
> +		 * Only require force in interactive mode to avoid
> +		 * breaking existing scripts
> +		 */
> +		if (!force && isatty(STDIN_FILENO)) {
> +			errx(EXIT_FAILURE,
> +			     _("This is destructive operation, data will " \
> +			       "be lost! Use the -f option to override."));
> +		}
> +		warnx(_("Operation forced, data will be lost!"));
        break;

 case 1: /* no signature */
        break;

 default: /* error */
> +		err(EXIT_FAILURE, _("failed to probe the device"));
        break;
 }


I think it's more readable ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

