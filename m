Return-Path: <SRS0=7FR5=7E=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDE6C433DF
	for <util-linux@archiver.kernel.org>; Fri, 22 May 2020 09:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBCA20738
	for <util-linux@archiver.kernel.org>; Fri, 22 May 2020 09:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/5BAa+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgEVJxS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 22 May 2020 05:53:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48666 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728247AbgEVJxR (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 22 May 2020 05:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590141196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i4mOSIaldlPA0A/R9iitaopXep9l4oOUQgtTjaMygHU=;
        b=M/5BAa+6ax7zMAd3XqDbEdgopxrcnUituXvtH/iumVqWa2W1FWsS0bSs2T4G+MxgoIB66T
        oPeoDpEqBXb3DsSScStPmNm52T3Wd8PHC6f3E3TmEGtmrwWsr3T6Y9t+oOJ1h25cA4WVvg
        G/4LgYQlg8+K3GH9q30D9BuKQc/USr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-6JX9VzTRP_2BfzTFrfHq9Q-1; Fri, 22 May 2020 05:53:12 -0400
X-MC-Unique: 6JX9VzTRP_2BfzTFrfHq9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBC8D18FE860;
        Fri, 22 May 2020 09:53:11 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1346134207;
        Fri, 22 May 2020 09:53:10 +0000 (UTC)
Date:   Fri, 22 May 2020 11:53:08 +0200
From:   Karel Zak <kzak@redhat.com>
To:     J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
Subject: Re: settimeofday() portability in hwclock
Message-ID: <20200522095308.tqgp37hen2zvcj3r@ws.net.home>
References: <20200511121954.pi5wpbwxqtli7gha@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511121954.pi5wpbwxqtli7gha@ws.net.home>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, May 11, 2020 at 02:19:58PM +0200, Karel Zak wrote:
>  please, review this patch. It seems we need to somehow hide libc
>  maintainers' creativity as settimeofday() have different behavior on
>  different libcs ;-) For example musl-C completely ignores TZ.
> 
>  I'd like to keep the current structure of our code (IMHO it's pretty
>  readable now), so I have  introduced  __set_time() and __set_timezone()
>  to hide the portability issues.

Applied.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

