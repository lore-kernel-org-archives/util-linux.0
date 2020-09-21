Return-Path: <SRS0=FFMN=C6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5E7C43464
	for <util-linux@archiver.kernel.org>; Mon, 21 Sep 2020 13:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F2221789
	for <util-linux@archiver.kernel.org>; Mon, 21 Sep 2020 13:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLsHcbu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgIUNHU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 21 Sep 2020 09:07:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40014 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726496AbgIUNHT (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 21 Sep 2020 09:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600693638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9Qj3adJaKjdPEDo08Ln/NfxXh7jpI/YK5ChLreId6U=;
        b=CLsHcbu6l4xNeuoXYkTLSHi+j6tzGa0y/Iu08yuccG92KO+SKh4Z2awjRG19rrHgqaunw+
        EuDVjSWT4PmZ6/dqzy1UtuyfDSzJLD+zDCaEsRq0BEMX24QhVEt1VUVX8rFkWDxYznCokE
        YsclI91qlX9G9UGl5LB5CSdcKkplIYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-U4RzRuFCPku07XC4XijeWw-1; Mon, 21 Sep 2020 09:07:14 -0400
X-MC-Unique: U4RzRuFCPku07XC4XijeWw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 663A957242;
        Mon, 21 Sep 2020 13:07:13 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.172])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 993E510021AA;
        Mon, 21 Sep 2020 13:07:12 +0000 (UTC)
Date:   Mon, 21 Sep 2020 15:07:09 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Lennard Hofmann <lennard.hofmann@web.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] column: Optionally keep empty lines in cols/rows mode
Message-ID: <20200921130709.zvyf4siigxrdg77p@ws.net.home>
References: <20200920125520.28204-1-lennard.hofmann@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920125520.28204-1-lennard.hofmann@web.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Sep 20, 2020 at 02:55:18PM +0200, Lennard Hofmann wrote:
> The following patches remove the unnecessary restriction of the -L option.

Good idea.

> patch below simply moves the existing logic to a new function `add_entry()` that
> gets called with an empty wcs if the -L option is present.
> 
> I am very new to C and mailing lists so I appreciate any feedback.

No problem :-)

> 
> text-utils/column.c
> | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/text-utils/column.c b/text-utils/column.c
> index 238dbab41..bc7851472 100644
> --- a/text-utils/column.c
> +++ b/text-utils/column.c
> @@ -487,6 +487,21 @@ static int add_emptyline_to_table(struct column_control *ctl)
>  	return 0;
>  }
> 
> +static void add_entry(struct column_control *ctl, size_t *maxents, wchar_t *wcs)
> +{
> +	if (ctl->nents <= *maxents) {
> +		*maxents += 1000;
> +		ctl->ents = xrealloc(ctl->ents, *maxents * sizeof(wchar_t *));
> +	}
> +	ctl->ents[ctl->nents] = wcs;

It would be more robust to add also

    ctl->nents++;

to this function.

> +}
> +
> +static void add_empty_entry(struct column_control *ctl, size_t *maxents)
> +{
> +	add_entry(ctl, maxents, mbs_to_wcs(""));
> +	ctl->nents++;
> +}
> +
>  static int read_input(struct column_control *ctl, FILE *fp)
>  {
>  	char *buf = NULL;
> @@ -512,8 +527,12 @@ static int read_input(struct column_control *ctl, FILE *fp)
>  				*p = '\0';
>  		}
>  		if (!str || !*str) {
> -			if (ctl->mode == COLUMN_MODE_TABLE && ctl->tab_empty_lines)
> -				add_emptyline_to_table(ctl);
> +			if (ctl->tab_empty_lines) {
> +				if (ctl->mode == COLUMN_MODE_TABLE)
> +					add_emptyline_to_table(ctl);
> +				else
> +					add_empty_entry(ctl, &maxents);

It seems add_empty_entry() is unnecessary. All you need is:

 else {
    if (!entry)
        empty = mbs_to_wcs("");
    add_entry(ctl, maxents, empty);
 }

and you will also resolve the issue with duplicate mbs_to_wcs("") 
(your patch 2/4).

> +			}
>  			continue;
>  		}
> 
> @@ -539,12 +558,7 @@ static int read_input(struct column_control *ctl, FILE *fp)
> 
>  		case COLUMN_MODE_FILLCOLS:
>  		case COLUMN_MODE_FILLROWS:
> -			if (ctl->nents <= maxents) {
> -				maxents += 1000;
> -				ctl->ents = xrealloc(ctl->ents,
> -						maxents * sizeof(wchar_t *));
> -			}
> -			ctl->ents[ctl->nents] = wcs;
> +			add_entry(ctl, &maxents, wcs);
>  			len = width(ctl->ents[ctl->nents]);

   len = width(wcs);

is necessary if ctl->nents will be incremented in add_entry().

>  			if (ctl->maxlength < len)
>  				ctl->maxlength = len;
 

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

