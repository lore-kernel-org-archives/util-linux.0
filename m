Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40995 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752489AbbHZXek (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 26 Aug 2015 19:34:40 -0400
Date: Thu, 27 Aug 2015 01:34:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Kees Cook <keescook@chromium.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] libmount: handle arbitrary line length for mounts
Message-ID: <20150826233439.GC2410@ws.net.home>
References: <20150826224923.GA11884@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150826224923.GA11884@www.outflux.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 26, 2015 at 03:49:23PM -0700, Kees Cook wrote:
> @@ -212,6 +212,8 @@ struct libmnt_table {
>  	int		comms;		/* enable/disable comment parsing */
>  	char		*comm_intro;	/* First comment in file */
>  	char		*comm_tail;	/* Last comment in file */
> +	char		*buf;		/* Memory for reading lines */
> +	size_t		buf_size;	/* Size of line-reading buffer */

It's overkill to add the buffer to the struct, it's necessary 
only in mnt_table_parse_next().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
