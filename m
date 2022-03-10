Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3262C433F5
	for <util-linux@archiver.kernel.org>; Thu, 10 Mar 2022 12:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiCJMx0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 10 Mar 2022 07:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbiCJMxY (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Mar 2022 07:53:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55DC214996A
        for <util-linux@vger.kernel.org>; Thu, 10 Mar 2022 04:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646916743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yNmP33ouIyriF1qDMKqV2JkcgYRqVcWW1Rh+IwmXB8s=;
        b=gCfqBacihs3tM8oJxjqrsUQ1HT7Jiba6ODetWoDZxM/aQVMGVvDbvjfSCasOeiu22oLzDk
        3X1rUS4KVMtVNPyZg6Vj35MDWxvHEzQ3s4jCXbzoEksZg+ofZUOW0+RcAaFKk0U20FaIVg
        LDIIQwb7bzly3c3QilTgKx8EmS6PKYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-ZXYNYcDoOOSE-sHj9RMAyA-1; Thu, 10 Mar 2022 07:52:20 -0500
X-MC-Unique: ZXYNYcDoOOSE-sHj9RMAyA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A8A1FC83;
        Thu, 10 Mar 2022 12:52:19 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8394B8495E;
        Thu, 10 Mar 2022 12:52:18 +0000 (UTC)
Date:   Thu, 10 Mar 2022 13:52:15 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Michael Trapp <michael.trapp@sap.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid, extend cache in uuid_generate_time_generic()
Message-ID: <20220310125215.stx3fsbjw6inkzw7@ws.net.home>
References: <20220224104651.74944-1-michael.trapp@sap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224104651.74944-1-michael.trapp@sap.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Feb 24, 2022 at 11:46:51AM +0100, Michael Trapp wrote:
> In a high load scenario, where an application continiously reads time
> based version 1 uuids from uuidd, we have noticed the following
> behaviour.

It means that your application reads more than 1000 UUIDs per second
in one thread :-) The "cache" has 1 second live-time.

> The application reads more uuids as there are available in the
> corresponding timeframe and each bulk request results in an increment of
> the clock sequence because of the 'step back' in time. Due to the
> 14bit size of the clock sequence this also results in overflows of
> the clock sequence.

hmm ...

> 
> As uuidd calls
>     uuid_generate_time_safe()
>        uuid_generate_time_generic()
> the default value for the bulk request in the '#ifdef HAVE_TLS' section
> of uuid_generate_time_generic() is set to 1000.
> 
> Extending the 'cache' of uuid_generate_time_generic() by increasing
> the default of num to 1000000 doesn't solve the issue, but reduces
> the clock sequence increments by factor 1000 and it also improves
> the uuid throughput in our setup by factor 3-4.

Well, uu.time_low is uint32_t, so there should be enough bytes to
handle 1000000 UUIDs by the cache (and it also increments uu.time_mid
and uu.time_hi_and_version).

If I read the code correctly than in theory the cache size could
be UINT32_MAX.

> It might be possible to implement a cache for
>   UUIDD_OP_BULK_TIME_UUID
>   UUIDD_OP_TIME_UUID
> in the uuidd request handling, but it would not be as simple as this fix
> in uuid_generate_time_generic().

The question is, what is the bottleneck? From my point            

    rewind/flock/fscanf/rewind/fprintf/fflush/unlock             
                                    
seems like a pretty expensive solution for the sequence file. Maybe for
the next development we should think about something more elegant like
a memory shared between uuidd instances. The question is also if uuidd 
has to share the file with the library because for extreme use-case like
databases, it does not make sense.

>  src/gen_uuid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied, thanks!

 https://github.com/util-linux/util-linux/commit/0f8de4902fe3f3512ee5043c5277d002a488a804


   Karel

