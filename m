Return-Path: <SRS0=zPEu=5R=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C0BC43331
	for <util-linux@archiver.kernel.org>; Wed,  1 Apr 2020 08:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD913206F5
	for <util-linux@archiver.kernel.org>; Wed,  1 Apr 2020 08:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFQzdpZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgDAIbO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:31:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30828 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726197AbgDAIbO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Apr 2020 04:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585729873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=peWlxpxg7yFSQqfKY2DFhK79hMqN21wC68PcNBJMyDs=;
        b=SFQzdpZua21sq4KPSHeZgyzt3+dyjiLqi6i8VhMSHmPMEk999q0I3pFXWoJBp2w27Q/OOH
        +s6LioyBQnB4cG5QjXwZhEa0a9YgQ5IQY6X/aOt2ckYdAzvlMnv6mD1p35ypzedAKs53OT
        Sw2CUON4vfkrD4XOIAkaJg86wQAfI5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-5EA67A3lOYKE45E5cZ2tIw-1; Wed, 01 Apr 2020 04:31:08 -0400
X-MC-Unique: 5EA67A3lOYKE45E5cZ2tIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EF6A18A6EC0;
        Wed,  1 Apr 2020 08:31:07 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 31B5099DEA;
        Wed,  1 Apr 2020 08:31:05 +0000 (UTC)
Date:   Wed, 1 Apr 2020 10:31:03 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Aurelien LAJOIE <orel@melix.net>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2] libuuid: improve uuid_unparse() performance
Message-ID: <20200401083103.ipberscb6yzvpu4r@ws.net.home>
References: <20200326143827.25879-1-orel@melix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326143827.25879-1-orel@melix.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Mar 26, 2020 at 03:38:27PM +0100, Aurelien LAJOIE wrote:
> +#ifdef UUID_UNPARSE_DEFAULT_UPPER
>  void uuid_unparse(const uuid_t uu, char *out)
> -{
> -	uuid_unparse_x(uu, out, FMT_DEFAULT);
> -}
> +	__attribute__((alias("uuid_unparse_upper")));
> +#else
> +void uuid_unparse(const uuid_t uu, char *out)
> +	__attribute__((alias("uuid_unparse_lower")));
> +#endif

The alias attribute is not portable to clang on Darwin.

 https://travis-ci.org/github/karelzak/util-linux/jobs/669244356?utm_medium=notification&utm_source=email

I have replaced the aliases with function calls.

 https://github.com/karelzak/util-linux/commit/bee464006776203a8cb545a35c86234181c7a55a

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

