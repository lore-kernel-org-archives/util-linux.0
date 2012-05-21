Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22101 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741Ab2EUJlW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 May 2012 05:41:22 -0400
Date: Mon, 21 May 2012 11:40:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 5/6] fdisk: introduce fdisk context
Message-ID: <20120521094054.GA14560@x2.net.home>
References: <1337530296.2677.16.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337530296.2677.16.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 20, 2012 at 06:11:36PM +0200, Davidlohr Bueso wrote:
> +struct fdisk_context *fdisk_new_context_from_filename(const char *fname)
> +{
> +	int fd;
> +	struct fdisk_context *cxt = NULL;
> +
> +	/*
> +	 * Attempt to open the device with r-w permissions
> +	 * by default, otherwise try read-only.
> +	 */
> +	if ((fd = open(fname, O_RDWR)) < 0)
> +		if ((fd = open(fname, O_RDONLY)) < 0)
> +			goto ret;

            return NULL;

> +	cxt = calloc(1, sizeof(*cxt));
> +	if (!cxt)
> +		goto ret;
> +
> +	cxt->dev_fd = fd;
> +	cxt->dev_path = strdup(fname);
> +	if (!cxt->dev_path)
> +		return NULL;

        goto fail;

 Please, think about it as about library, it meas without memory and
 fd leaks :-)

> +ret:
> +	return cxt;
> +}
> +

   return cxt;

fail:
   errsv = errno;
   fdisk_free_context(cxt);
   errno = errsv;
   return NULL;


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
