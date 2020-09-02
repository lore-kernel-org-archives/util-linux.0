Return-Path: <SRS0=B7Lt=CL=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2EBC433E7
	for <util-linux@archiver.kernel.org>; Wed,  2 Sep 2020 09:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99B0A20773
	for <util-linux@archiver.kernel.org>; Wed,  2 Sep 2020 09:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaNvNCxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgIBJVf (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgIBJVf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 2 Sep 2020 05:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599038493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u7ZOD7/phGsJgeYJsZQ66733zRf2pvAZtvP/9fFIx44=;
        b=SaNvNCxM9eMXKqweKU6AqlYuVV6Y41tw97gmSkC+7DXLxsBjQT53IRIx3tgJQVtQ2WxtuM
        TGDp2tOjEtxpvZTP2qmEDOXVDWj7XWc85H9cehXUWMy9CvjMGq1PENNGsjeOM3CdXI2btE
        tKAbB3dm7+wUREcbdIT/qlolJFWYwOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-0AuNtDbvPCiCJ1F1cSCZGA-1; Wed, 02 Sep 2020 05:21:29 -0400
X-MC-Unique: 0AuNtDbvPCiCJ1F1cSCZGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2598A100746C;
        Wed,  2 Sep 2020 09:21:28 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AE337DA59;
        Wed,  2 Sep 2020 09:21:27 +0000 (UTC)
Date:   Wed, 2 Sep 2020 11:21:24 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Sami Kerola <kerolasa@iki.fi>
Cc:     util-linux@vger.kernel.org, Sami Kerola <kerolasa@cloudflare.com>
Subject: Re: [PATCH] nologin: use sendfile() to submit message to user
Message-ID: <20200902092124.fukwxm3iabg7uy2x@ws.net.home>
References: <20200901190131.4153-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901190131.4153-1-kerolasa@iki.fi>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Sep 01, 2020 at 08:01:31PM +0100, Sami Kerola wrote:
> A read() write() pair can be replaced with sendfile(), and it should be more
> efficient than suffling bytes back and forth user and kernel space.

Good idea, but not sure how portable is it to another OS. Maybe add
a fallback to include/fileutils.h or mark nologin by "if LINUX" in the
Makefile.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

