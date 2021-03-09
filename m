Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894DCC433DB
	for <util-linux@archiver.kernel.org>; Tue,  9 Mar 2021 09:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C1C65147
	for <util-linux@archiver.kernel.org>; Tue,  9 Mar 2021 09:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCIJSy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 9 Mar 2021 04:18:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229875AbhCIJSf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 9 Mar 2021 04:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615281515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Axt50I4cNQmTBmiJWht0yiB5Rjkxk/z2/ZoJbTEZN3Y=;
        b=Vv+u+o6L4/1/uYBfh7PfI/Lt0Yy5HzKnllPUhzYtFksqy42FX0SgURRS9UABLs232EszvH
        t+nFMeUBKmHa4hfczqwT3/NwZuHjlGYdpXr9jTkTN0Uvk6EbVaCDHX4I7ypMQMQ1wgDaCk
        NHjn7KTCSFuSMbEUKyHcVF/PpQp783Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-1nR_h7DoMuaIwwshFZSm-w-1; Tue, 09 Mar 2021 04:18:31 -0500
X-MC-Unique: 1nR_h7DoMuaIwwshFZSm-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E75C587A83F;
        Tue,  9 Mar 2021 09:18:30 +0000 (UTC)
Received: from ws.net.home (ovpn-113-171.ams2.redhat.com [10.36.113.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 370D3679FA;
        Tue,  9 Mar 2021 09:18:30 +0000 (UTC)
Date:   Tue, 9 Mar 2021 10:18:27 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Howard Lum <hlum@synamedia.com>
Cc:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: lscpu and Intel Turbo Boost
Message-ID: <20210309091827.hogycuynnyplc7q4@ws.net.home>
References: <CWXP265MB17024AF7959F3132E333F6DAC8BC0@CWXP265MB1702.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB17020C63B570E7B6BA256F6EC8B69@CWXP265MB1702.GBRP265.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CWXP265MB17020C63B570E7B6BA256F6EC8B69@CWXP265MB1702.GBRP265.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Feb 01, 2021 at 02:16:41PM +0000, Howard Lum wrote:
> I have a server with a Power Regulator control. When this is set for
> "OS Control Mode", the lscpu output reports CPU max MHz and CPU min
> MHz info. When the control is set to "Static High Performance", the
> lscpu output only reports "CPU MHz" and the value is the same as the
> CPU base frequency. Does this mean that the CPU is operating at the
> base frequency and is not using Intel Turbo Boost?

"CPU MHz" is value from /proc/cpuinfo usually from the first CPU and
it's actual frequency of the processor. 

The next lscpu version will not show this value as it's useless to 
show frequency for the first CPU if you have more CPUs ...

And the min and max are read from

  /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_max_freq
  /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_min_freq

and describe frequency range.

Use grep "cpu MHz" /proc/cpuinfo to get the current frequencies, or in
the next lscpu version it will be possible use use "lscpu -eCPU,MHZ"
to get the same.

I have no clue about "Intel Turbo Boost" and how Linux report/use it,
but I guess that "cpu MHz" from /proc/cpuinfo is what kernel thinks
about the speed.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

