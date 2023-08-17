Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C686C41513
	for <util-linux@archiver.kernel.org>; Thu, 17 Aug 2023 09:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349192AbjHQJzB (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 17 Aug 2023 05:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349841AbjHQJy4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 17 Aug 2023 05:54:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7BFE40
        for <util-linux@vger.kernel.org>; Thu, 17 Aug 2023 02:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692266049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u46htDS67ikLqnOM8gcW0i0MFkpJ2FGZ8RVvy0jKKVI=;
        b=LzehzuU2kC4zF/nuzLhux8LGWkhV02M9YbIPmeo7ECJaSLlNBsrSNb7Ju/cpGkVrFmwzLG
        EruvWQaaMfTQ5Ubb4F5vI+2NW5ozXTakbLDmgKwvu1SCHOfxtNtyNa3kdaEdj/7w7I70Vs
        ZI8gO5gwla29fGhB3aSs+5MbW9W/e1s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-AqnWUopQOpSktBgBX17GPw-1; Thu, 17 Aug 2023 05:54:04 -0400
X-MC-Unique: AqnWUopQOpSktBgBX17GPw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C39298564F0;
        Thu, 17 Aug 2023 09:54:03 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51A0DC15BAD;
        Thu, 17 Aug 2023 09:54:03 +0000 (UTC)
Date:   Thu, 17 Aug 2023 11:54:01 +0200
From:   Karel Zak <kzak@redhat.com>
To:     fdmanana@kernel.org
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: Fix regression when mounting with atime
Message-ID: <20230817095401.ystzfnqn5udsbrij@ws.net.home>
References: <aeef1a885d791881a6cf0e61e405f5490f060701.1692264006.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeef1a885d791881a6cf0e61e405f5490f060701.1692264006.git.fdmanana@suse.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Aug 17, 2023 at 10:20:13AM +0100, fdmanana@kernel.org wrote:
> A regression was introduced in v2.39 that causes mounting with the atime
> option to fail:
> 
>   $ mkfs.ext4 -F /dev/sdi
>   $ mount -o atime /dev/sdi /mnt/sdi
>   mount: /mnt/sdi: not mount point or bad option.
>          dmesg(1) may have more information after failed mount system call.
 
Great timing! I just released bugfix tarball v2.39.2 a few minutes ago :-)

> diff --git a/libmount/src/optlist.c b/libmount/src/optlist.c
> index e93810b47..d0afc94f7 100644
> --- a/libmount/src/optlist.c
> +++ b/libmount/src/optlist.c
> @@ -875,7 +875,18 @@ int mnt_optlist_get_attrs(struct libmnt_optlist *ls, uint64_t *set, uint64_t *cl
>  
>  		if (opt->ent->mask & MNT_INVERT) {
>  			DBG(OPTLIST, ul_debugobj(ls, " clr: %s", opt->ent->name));
> -			*clr |= x;
> +			/*
> +			 * All atime settings are mutually exclusive so *clr must
> +			 * have MOUNT_ATTR__ATIME set.
> +			 *
> +			 * See the function fs/namespace.c:build_mount_kattr()
> +			 * in the linux kernel source.
> +			 */
> +			if (x == MOUNT_ATTR_RELATIME || x == MOUNT_ATTR_NOATIME ||
> +			    x == MOUNT_ATTR_STRICTATIME)
> +				*clr |= MOUNT_ATTR__ATIME;
> +			else
> +				*clr |= x;

Ah, the libmount code does this, but only when set a new option. This is
missing for inverted options (like atime).

> +# Test that the atime option works after the migration to use the new kernel mount APIs.
> +ts_run $TESTPROG --mount -o atime $DEVICE $MOUNTPOINT >> $TS_OUTPUT 2>> $TS_ERRLOG
> +$TS_CMD_FINDMNT --kernel --mountpoint $MOUNTPOINT -o VFS-OPTIONS -n >> $TS_OUTPUT 2>> $TS_ERRLOG
> +is_mounted $DEVICE || echo "$DEVICE not mounted" >> $TS_OUTPUT 2>> $TS_ERRLOG
> +ts_run $TESTPROG --umount $MOUNTPOINT >> $TS_OUTPUT 2>> $TS_ERRLOG
> +is_mounted $DEVICE && echo "$DEVICE still mounted" >> $TS_OUTPUT 2>> $TS_ERRLOG
> +
> +ts_finalize_subtest

Applied, thanks, and extra thanks for the tests!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

