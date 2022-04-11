Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A098EC433F5
	for <util-linux@archiver.kernel.org>; Mon, 11 Apr 2022 10:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243588AbiDKKK0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 Apr 2022 06:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244005AbiDKKKZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 Apr 2022 06:10:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 987892181C
        for <util-linux@vger.kernel.org>; Mon, 11 Apr 2022 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649671691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E3WpW3X1TA8Afjalg905WV4wFil3kE5sUZD1JFxpxC4=;
        b=WMsLCbJJG63My+SBibKx/uJ2N/Yn8K8iX+0mNQ+SGJve0kES0qXLK+tbFvh7Uc+nqM9isP
        RxStsKjQ22du+n/n7OEpZVqUYhqdYYJRpQcCzlmV+4iB3dRHqZv1LSbeJiwx2+xah8ScFh
        18hR+dzWgQLquUt5WZvnrETBaRBJkqU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-Fbr-qawRN4O9fX2Y_clqgg-1; Mon, 11 Apr 2022 06:08:10 -0400
X-MC-Unique: Fbr-qawRN4O9fX2Y_clqgg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0F403801EC6;
        Mon, 11 Apr 2022 10:08:09 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 21674403375;
        Mon, 11 Apr 2022 10:08:09 +0000 (UTC)
Date:   Mon, 11 Apr 2022 12:08:06 +0200
From:   Karel Zak <kzak@redhat.com>
To:     1003095@bugs.debian.org, Chris Hofstaedtler <zeha@debian.org>,
        util-linux@vger.kernel.org
Cc:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Subject: Re: Bug#1003095: /usr/bin/script: hangs when child doesn't read
 input fast enough
Message-ID: <20220411100806.bfplpv36sdixd6uu@ws.net.home>
References: <20220103230422.syzm2ryzcixuhl7r@tarta.nabijaczleweli.xyz>
 <20220104162454.3agbsfqfpvaxr5ny@percival.namespace.at>
 <20220104173124.lv2fyxuxuvc34jdo@tarta.nabijaczleweli.xyz>
 <20220108145406.vkiuvl6iji4oypay@tarta.nabijaczleweli.xyz>
 <20220113232811.puu3pbtzjvzgys3o@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220113232811.puu3pbtzjvzgys3o@tarta.nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jan 14, 2022 at 12:28:11AM +0100, наб wrote:
> -static int write_to_child(struct ul_pty *pty, char *buf, size_t bufsz)
> +static int schedule_child_write(struct ul_pty *pty, char *buf, size_t bufsz, int final)
>  {
> -	return write_all(pty->master, buf, bufsz);
> +	struct ul_pty_child_buffer *stash = calloc(1, sizeof(*stash));

It means that for each activity on the file descriptor it will
allocate a new buffer (in BUFSIZ). It seems pretty expensive.

Cannot we reuse the buffers? 

Maybe use include/list.h, define two lists, one for not-yet-written 
buffers and another for ready-to-use buffers and move from one list to
another in schedule_child_write() and flush_child_buffers().

> +	if (!stash)
> +		return -1;
> +
> +	memcpy(stash->buf, buf, bufsz);
> +	stash->size = bufsz;
> +	stash->final_input = final ? 1 : 0;
> +
> +	if (pty->child_buffer_head)
> +		pty->child_buffer_tail = pty->child_buffer_tail->next = stash;
> +	else
> +		pty->child_buffer_head = pty->child_buffer_tail = stash;
> +	return 0;
>  }
>  
>  /*
> @@ -311,16 +329,13 @@ static int write_to_child(struct ul_pty
>   * maintains master+slave tty stuff within the session. Use pipe to write to
>   * pty and assume non-interactive (tee-like) behavior is NOT well supported.
>   */
> -void ul_pty_write_eof_to_child(struct ul_pty *pty)
> +static void drain(struct ul_pty *pty)

drain_child_buffers() :-)


Anyway, it looks good.

    Karel



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

