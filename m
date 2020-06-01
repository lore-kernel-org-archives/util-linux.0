Return-Path: <SRS0=/ORA=7O=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24378C433E0
	for <util-linux@archiver.kernel.org>; Mon,  1 Jun 2020 08:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF708206C3
	for <util-linux@archiver.kernel.org>; Mon,  1 Jun 2020 08:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAwx2NAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgFAIN7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:13:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22050 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726056AbgFAIN7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 1 Jun 2020 04:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590999237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a8AwMq/UaCf/JGemvVRKvIBPJtxyqlLeH3RKIapaCgs=;
        b=AAwx2NAr6jg2FXWgqIjALu8pBfWnkaKU9A+nLoWL3Uy6MIAkxFbnAfWo/hVVyo5hxPCwRF
        kiRJHSM054BpOnaG7KLU9R40nN3Ome53iK1Gru/e0I/PMVKpbB0c/rSLdXHCtWajZYyYXh
        jhQKopf3j/7UtcHpoj8vXCaekNxbuHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-YjsHFaQxPLaKgvMA4pvqNQ-1; Mon, 01 Jun 2020 04:13:53 -0400
X-MC-Unique: YjsHFaQxPLaKgvMA4pvqNQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7C5B19200D7;
        Mon,  1 Jun 2020 08:13:52 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B9BF71000322;
        Mon,  1 Jun 2020 08:13:51 +0000 (UTC)
Date:   Mon, 1 Jun 2020 10:13:49 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org, Martin Wilck <martin.wilck@suse.com>
Subject: Re: [PATCH] blockdev: Don't fail on missing start sector
Message-ID: <20200601081349.uirtbn2u2bfztnq4@ws.net.home>
References: <a7a4f974-8a32-efb3-0ba3-a25e77145946@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7a4f974-8a32-efb3-0ba3-a25e77145946@suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jun 01, 2020 at 01:35:44AM +0200, Stanislav Brabec wrote:
> Device mapper devices don't provide start sector.

for which type of the device/mapping? I'd like to reproduce this
issue.

> It causes "blockdev --report" error:
> blockdev: /dev/dm-9: failed to read partition start from sysfs: No such
> file or directory
> 
> There is no reliable way to detect a geometry in this case.
> Report N/A instead.

I guess the "start" file missing in the sysfs/ in this case, right?

>              if (ul_path_read_u64(pc, &start, "start") != 0)
> -                err(EXIT_FAILURE,
> -                    _("%s: failed to read partition start from sysfs"),
> -                    device);
> +                /* TRANSLATORS: Start sector not available. Max. 10
> letters. */
> +                sprintf(start_str, "%10s", _("N/A"));
>          }
>          ul_unref_path(pc);
>      }
> +    if (start_str[0] == 0)
> +        sprintf(start_str, "%10ju", start);


Maybe we ca use ul_path_read_buffer() rather than ul_path_read_u64() to keep 
it as string and to avoid sprintf().

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

