Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C910C433DB
	for <util-linux@archiver.kernel.org>; Tue,  5 Jan 2021 12:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2606D22AAA
	for <util-linux@archiver.kernel.org>; Tue,  5 Jan 2021 12:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbhAEMJc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:09:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbhAEMJc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 5 Jan 2021 07:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609848485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AlJxWrSKXMRBM8VtFGB0paFNPKi3bbVjjoo9AbBj9CI=;
        b=J/aOVMhk6JG4aU1RI2bmr5eIxN+l2kmLDu22gH9gIt5O9isFufxDJzsG+QqV/E5PoFZdNc
        k+yUCWbRsOjzuJN4DkQHn33lDgFpXTw9l1rQPTNZ88WA048apB85rmr15/fOKhXsPmRqtU
        LV/udaXdUrQkfxWaoEe3LpwJ1w78rnA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-BYWXOEMzMpy2Bu6IUJavNA-1; Tue, 05 Jan 2021 07:08:03 -0500
X-MC-Unique: BYWXOEMzMpy2Bu6IUJavNA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6F4B59;
        Tue,  5 Jan 2021 12:08:02 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1112A5D6CF;
        Tue,  5 Jan 2021 12:08:01 +0000 (UTC)
Date:   Tue, 5 Jan 2021 13:07:59 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: fsck silently exits when fstype-specific fsck is not found
Message-ID: <20210105120759.iz2lkufewlpqld6f@ws.net.home>
References: <20201229191814.ltehybec7ql67xm5@zeha.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229191814.ltehybec7ql67xm5@zeha.at>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Dec 29, 2020 at 08:18:14PM +0100, Chris Hofstaedtler wrote:
> Hi,
> 
> I just noticed that fsck, when given a single device name, silently
> exits when it cannot find an appropriate fsck.%s program.
> 
> Example:
>   (/dev/sda1 is an EFI System Partition, so type=vfat)
>   # fsck -V /dev/sda1
>   fsck from util-linux 2.36.1
>   # echo $?
>   0
> 
> Note that it also does not warn about fsck.vfat not being found or
> anything really.
> 
> This appears because fsck.c has a "really_wanted" list of fstypes;
> anything not in there gets the mentioned behaviour.
> 
> I find this to be very surprising. What are the reasons for this?

I guess to avoid unnecessary warnings on systems with filesystems
where fsck is not (or wasn't) implemented like btrfs or xfs.

> I could try changing this code path, but I'm not sure if this is
> expected in the first place?

Maybe we can introduce some another list of filesystems where fsck is
optional and recommended, but it's no error when not available -- it
means print warning, but do not exit with an error.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

