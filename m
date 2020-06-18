Return-Path: <SRS0=vf6E=77=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696F7C433E0
	for <util-linux@archiver.kernel.org>; Thu, 18 Jun 2020 10:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1D62186A
	for <util-linux@archiver.kernel.org>; Thu, 18 Jun 2020 10:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDgYLbI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgFRKdj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:33:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41505 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726991AbgFRKdi (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 18 Jun 2020 06:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592476417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3VgnOlCxzWY/qQn8F54FcPDFLDn07OvjpMoOTfB7onw=;
        b=TDgYLbI6RX7F75nKdKbfRhmy108T6AKXHINMl8Xj8wQLS8PxvqdR5bc21HT2RS19zRUfCJ
        IDm/YRCCIVG8IHTUs6Dkw4O0TT9DJi1dvPIhIfIVmLWDAIN6JK6BKJwhWXuhVhvLjUo6Kh
        0/KgixKKih35dDJhmQhc92Bq+8LIpeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-s5JMYZGoNO60JmxeFIp4xQ-1; Thu, 18 Jun 2020 06:33:33 -0400
X-MC-Unique: s5JMYZGoNO60JmxeFIp4xQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 506AC1005512
        for <util-linux@vger.kernel.org>; Thu, 18 Jun 2020 10:33:32 +0000 (UTC)
Received: from work (unknown [10.40.192.238])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8651960BF3;
        Thu, 18 Jun 2020 10:33:31 +0000 (UTC)
Date:   Thu, 18 Jun 2020 12:33:27 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] blkdiscard: Refuse to proceed if signatures are found
Message-ID: <20200618103327.o64jhcboobwpnr4a@work>
References: <20200618092916.12191-1-lczerner@redhat.com>
 <20200618100626.f5uyuxomfhbnhibn@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618100626.f5uyuxomfhbnhibn@ws.net.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jun 18, 2020 at 12:06:26PM +0200, Karel Zak wrote:
> On Thu, Jun 18, 2020 at 11:29:16AM +0200, Lukas Czerner wrote:
> > With this commit blkdiscard will check for existing signatures on the
> > device and refuse to continue if any are found unless the operation is
> > forced with the -f option.
> 
> Good idea.
> 
> > +/*
> > + * Check existing signature on the open fd
> > + * Returns	0  if no signature was found
> > + * 		1  if a signature was found
> 
> this is not true, 0 means detected, 1 not found
> 
> > + * 		<0 on error
> > + */
> > +static int device_empty(int fd, char *path)
> 
> This is difficult for to read, at first glance it seems according
> to function name that 1 means "yes, it's empty".
>       
> Maybe rename it to probe_device().
> 
> > +{
> > +	const char *type;
> > +	blkid_probe pr = NULL;
> > +	int ret = -1;
> > +
> > +	pr = blkid_new_probe();
> > +	if (!pr || blkid_probe_set_device(pr, fd, 0, 0))
> > +		return ret;
> > +
> > +	blkid_probe_enable_superblocks(pr, TRUE);
> > +	blkid_probe_enable_partitions(pr, TRUE);
> > +
> > +	ret = blkid_do_fullprobe(pr);
> > +	if (ret)
> > +		return ret;
> 
> yes, blkid_do_fullprobe() returns: 0 on success, 1 if nothing is detected or -1 on case of error.
> 
> > +
> > +	if (!blkid_probe_lookup_value(pr, "TYPE", &type, NULL)) {
> > +		warnx("%s contains existing file system (%s).",path ,type);
> > +	} else if (!blkid_probe_lookup_value(pr, "PTTYPE", &type, NULL)) {
> > +		warnx("%s contains existing partition (%s).",path ,type);
> > +	} else {
> > +		warnx("%s contains existing signature.", path);
> > +	}
> > +
> > +	blkid_free_probe(pr);
> > +	return ret;
> 
> This is always 0.
> 
> > +}
> >  
> >  int main(int argc, char **argv)
> >  {
> >  	char *path;
> > -	int c, fd, verbose = 0, secsize, force = 0;
> > +	int c, fd, ret, verbose = 0, secsize, force = 0;
> >  	uint64_t end, blksize, step, range[2], stats[2];
> >  	struct stat sb;
> >  	struct timeval now, last;
> > @@ -184,7 +219,7 @@ int main(int argc, char **argv)
> >  		errtryhelp(EXIT_FAILURE);
> >  	}
> >  
> > -	fd = open(path, O_WRONLY | (force ? 0 : O_EXCL));
> > +	fd = open(path, O_RDWR | (force ? 0 : O_EXCL));
> >  	if (fd < 0)
> >  		err(EXIT_FAILURE, _("cannot open %s"), path);
> >  
> > @@ -217,6 +252,21 @@ int main(int argc, char **argv)
> >  		errx(EXIT_FAILURE, _("%s: length %" PRIu64 " is not aligned "
> >  			 "to sector size %i"), path, range[1], secsize);
> >  
> > +	 /* Check for existing signatures on the device */
> > +	if ((ret = device_empty(fd, path)) == 0) {
> 
>  What about:
> 
>  switch (probe_device(fd, path)) {
>  case 0: /* signature detected */
> > +		/*
> > +		 * Only require force in interactive mode to avoid
> > +		 * breaking existing scripts
> > +		 */
> > +		if (!force && isatty(STDIN_FILENO)) {
> > +			errx(EXIT_FAILURE,
> > +			     _("This is destructive operation, data will " \
> > +			       "be lost! Use the -f option to override."));
> > +		}
> > +		warnx(_("Operation forced, data will be lost!"));
>         break;
> 
>  case 1: /* no signature */
>         break;
> 
>  default: /* error */
> > +		err(EXIT_FAILURE, _("failed to probe the device"));
>         break;
>  }
> 
> 
> I think it's more readable ;-)

Sure, I can do that. The bad comment definitelly makes it more confusing
that it needed to be :)

if (!device_empty()) was the intention but then I still have to deal
with the error. I'll do the switch change.

-Lukas

> 
>     Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com

