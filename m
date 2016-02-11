Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59022 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091AbcBKKNe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 11 Feb 2016 05:13:34 -0500
Date: Thu, 11 Feb 2016 11:13:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] swapon: add control struct
Message-ID: <20160211101331.ez6no7v2faigigqh@ws.net.home>
References: <1454420410-654-1-git-send-email-kerolasa@iki.fi>
 <1454420410-654-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454420410-654-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 02, 2016 at 01:40:08PM +0000, Sami Kerola wrote:
> -static void swap_get_info(const char *hdr, char **label, char **uuid)
> +static void swap_get_info(struct swapon_ctl *ctl, const char *hdr)
>  {
>  	struct swap_header_v1_2 *s = (struct swap_header_v1_2 *) hdr;
>  
> -	if (s && *s->volume_name && label)
> -		*label = xstrdup(s->volume_name);
> +	if (s && *s->volume_name && ctl->label)
> +		ctl->label = xstrdup(s->volume_name);

Your semantic for "label" is different that in the original version
where label was pointer to pointer, so "&& label" had sense. In your
code "&& ctl->label" is always true.

I'll fix it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
