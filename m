Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18547C4332F
	for <util-linux@archiver.kernel.org>; Tue,  7 Nov 2023 10:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjKGKfX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 7 Nov 2023 05:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjKGKfW (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 7 Nov 2023 05:35:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB091384F
        for <util-linux@vger.kernel.org>; Tue,  7 Nov 2023 02:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699353189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LtuyfeXDrWwD0GLwzAOrX/exFC5OF5Ptn/v5o7TOEmQ=;
        b=Dzz1FXLAea+COsV6MwfvYRFnIscicGts41RBSaPQ6A7c78YzLhb0cecjXEglysi7fiV55K
        FsnZC8btg86TBag+Agzfpi2BvMGZiJ6v0bLuLGf5Hx5gUqbMWZwxzUHe6Hqo2q/Oq4dVUb
        LrpxDTR4e9jZ/97MXEXFY00HzwAiDbI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-Y0Cd1ujzN7OTL1WeAbj83w-1; Tue, 07 Nov 2023 05:33:05 -0500
X-MC-Unique: Y0Cd1ujzN7OTL1WeAbj83w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70F47810FC6;
        Tue,  7 Nov 2023 10:33:05 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D645125C1;
        Tue,  7 Nov 2023 10:33:04 +0000 (UTC)
Date:   Tue, 7 Nov 2023 11:33:02 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Michael Trapp <michael.trapp@sap.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: avoid truncate clocks.txt to improve performance
Message-ID: <20231107103302.paeetyxxlu36me57@ws.net.home>
References: <i4fuwkw2hvj6gge3uhuy3jlq5gg4ls7djibygcb5duxhumvllx@cernuqwwl7pi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i4fuwkw2hvj6gge3uhuy3jlq5gg4ls7djibygcb5duxhumvllx@cernuqwwl7pi>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Michael, any objection or comment?

 I have seen reports with XFS performance issues too, but I guess it's
 possible to solve the problem with uuidd and --cont-clock.

    Karel

On Tue, Oct 10, 2023 at 06:08:59PM -0500, Goldwyn Rodrigues wrote:
> Instead of explicitly truncating clocks.txt file, pad with
> whitespaces in the end of file.
> This is done to improve performance of libuuid on xfs
> filesystems. Instead of truncating the file, pad it with whitespaces.
> This is anyways used as a failsafe method in case truncate fails.
> 
> The reason why this regression was introduced was because of:
> 869ae85dae64 ("xfs: flush new eof page on truncate to avoid post-eof corruption")
> 
> An attempt to move the clocks.txt to /run (tmpfs) has been attempted before
> [1] and with commit ab2e7dd17 ("libuuid: move clock state file from
> /var/lib to /var/run"). The latter was reverted.
> 
> [1] https://www.spinics.net/lists/util-linux-ng/msg17331.html
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> ---
>  libuuid/src/gen_uuid.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
> index 619ef0131..97e2dec4e 100644
> --- a/libuuid/src/gen_uuid.c
> +++ b/libuuid/src/gen_uuid.c
> @@ -229,7 +229,6 @@ static int get_clock(uint32_t *clock_high, uint32_t *clock_low,
>  	struct timeval			tv;
>  	uint64_t			clock_reg;
>  	mode_t				save_umask;
> -	int				len;
>  	int				ret = 0;
>  
>  	if (state_fd == -1)
> @@ -324,14 +323,10 @@ try_again:
>  
>  	if (state_fd >= 0) {
>  		rewind(state_f);
> -		len = fprintf(state_f,
> -			      "clock: %04x tv: %016ld %08ld adj: %08d\n",
> +		fprintf(state_f,
> +			      "clock: %04x tv: %016ld %08ld adj: %08d                   \n",
>  			      clock_seq, (long)last.tv_sec, (long)last.tv_usec, adjustment);
>  		fflush(state_f);
> -		if (ftruncate(state_fd, len) < 0) {
> -			fprintf(state_f, "                   \n");
> -			fflush(state_f);
> -		}
>  		rewind(state_f);
>  		flock(state_fd, LOCK_UN);
>  	}
> -- 
> 2.42.0
> 
> 
> -- 
> Goldwyn
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

