Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901ABC433EF
	for <util-linux@archiver.kernel.org>; Fri, 29 Apr 2022 11:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiD2Ltd (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 29 Apr 2022 07:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358676AbiD2Ltc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 29 Apr 2022 07:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADE57B3C49
        for <util-linux@vger.kernel.org>; Fri, 29 Apr 2022 04:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651232772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oquXK6GvSzowhrIE8oaF8++Bc0Fob4fNiy+J18KlQXA=;
        b=UoX02bxD0nDmzQbMoxEF1rVF63EoGb0O7ph47q8QRQPLy7ByjtDLB8yatsXeXeMh0x/bcv
        r1fimO+alC4dXwkAwgviQ3G5jClraCsHbw9z0l10n+aD7Xf9dutwcnbYv5BZnG8Wl6kRX3
        HfuPVuBPPlWcj/IB/+GhsOiNEtzWzkQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-295-9Cb11jGhOLez5FWtUhsV5A-1; Fri, 29 Apr 2022 07:46:11 -0400
X-MC-Unique: 9Cb11jGhOLez5FWtUhsV5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB1EC2811820;
        Fri, 29 Apr 2022 11:46:10 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 22CA14010E23;
        Fri, 29 Apr 2022 11:46:09 +0000 (UTC)
Date:   Fri, 29 Apr 2022 13:46:07 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Michael Trapp <michael.trapp@sap.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: uuidd: Implement continuous clock handling for time based UUIDs
Message-ID: <20220429114607.6ggqozhcir7pp2h2@ws.net.home>
References: <20220422100830.32187-1-michael.trapp@sap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422100830.32187-1-michael.trapp@sap.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Apr 22, 2022 at 12:08:30PM +0200, Michael Trapp wrote:
> +static int get_clock_cont(uint32_t *clock_high,
> +			    uint32_t *clock_low,
> +			    int num)
> +{
> +	/* 100ns based time offset according to RFC 4122. 4.1.4. */
> +	const uint64_t reg_offset = (((uint64_t) 0x01B21DD2) << 32) + 0x13814000;
> +	THREAD_LOCAL uint64_t last_clock_reg = 0;
> +	uint64_t clock_reg;
> +
> +	if (last_clock_reg == 0)
> +		last_clock_reg = get_clock_counter();
> +
> +	clock_reg = get_clock_counter();
> +	clock_reg += MAX_ADJUSTMENT;
> +
> +	if ((last_clock_reg + num) >= clock_reg)
> +		return -1;


If I read your code correctly, it initializes the clock at uuidd start
and then continues (forever). Each short time of inactivity will
increase the difference between time stored in UUIDs and real-time.
For example, this difference will be huge for databases where users
don't allocate new UUIDs at night.
                                 

Maybe we can implement some hybrid model that resets the continuous
clock start point (last_clock_reg) from time to time, for example,
every minute (hour, ...). I don't think it will be a performance
problem when it does not use LIBUUID_CLOCK_FILE. The result will be
UUIDs that match with reality. Does it make sense?

> +
> +	*clock_high = (last_clock_reg + reg_offset) >> 32;
> +	*clock_low = last_clock_reg + reg_offset;
> +	last_clock_reg += num;
> +
> +	return 0;
> +}

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

