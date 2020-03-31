Return-Path: <SRS0=mypX=5Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16331C2D0EE
	for <util-linux@archiver.kernel.org>; Tue, 31 Mar 2020 13:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57A520781
	for <util-linux@archiver.kernel.org>; Tue, 31 Mar 2020 13:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpqME6M1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgCaNec (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:34:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39325 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730755AbgCaNec (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 31 Mar 2020 09:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585661671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TwnjgAOwdupx6xMWhSnLHAtlQ/YDkrFjuJDOUe7xe3Y=;
        b=dpqME6M1McVQfZOlq8Qt/NwctbccXrhDV3Xhz3Oe20enPFSDBpr+gJ38iwELTp0pwWkWm4
        iiQcW1pj5DIgGm0WXKoc43omtRH+Qj4gkZ43dd7CkHEOlzAJF//9b9HgBlhjlHhQvAjkCZ
        QCAH19twr+2xTG/SAr5zER1n55abQLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-yy3-qrd0N1e07_tn0h_yYg-1; Tue, 31 Mar 2020 09:34:29 -0400
X-MC-Unique: yy3-qrd0N1e07_tn0h_yYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B386100DFC2;
        Tue, 31 Mar 2020 13:34:28 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A022819C58;
        Tue, 31 Mar 2020 13:34:27 +0000 (UTC)
Date:   Tue, 31 Mar 2020 15:34:25 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Aurelien LAJOIE <orel@melix.net>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] cal: use a const char*
Message-ID: <20200331133425.6tst56ygew6durew@ws.net.home>
References: <20200328223341.11463-1-orel@melix.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328223341.11463-1-orel@melix.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Mar 28, 2020 at 11:33:39PM +0100, Aurelien LAJOIE wrote:
>  misc-utils/cal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All three patches applied. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

