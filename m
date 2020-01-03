Return-Path: <SRS0=ZGwe=2Y=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60BBC2D0C2
	for <util-linux@archiver.kernel.org>; Fri,  3 Jan 2020 11:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A900F2085B
	for <util-linux@archiver.kernel.org>; Fri,  3 Jan 2020 11:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUInecwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgACLTR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 3 Jan 2020 06:19:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41535 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727220AbgACLTQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 3 Jan 2020 06:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578050356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YKnuxGq989uy69pPCo23LmarH2fZ743S4cuyygD7xfQ=;
        b=jUInecwTzPdwekvji4WZIgRIjuYF4qpV8bF0HYl01UaE9clTjC86FuxFXO3tT297eEnA9X
        kPNOQWMYuma3Ze1TdLoa8jI50OdpMe3GO2bWNjWY+Ddzx2w73lRPRGjEBIi0mt3KBKEgB/
        GSdHJjimcoaRYTZHCzhP3NqHHdGgzK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-oYyFzJjiOkuk6Zy4fKG9rg-1; Fri, 03 Jan 2020 06:19:12 -0500
X-MC-Unique: oYyFzJjiOkuk6Zy4fKG9rg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E71A107ACCD;
        Fri,  3 Jan 2020 11:19:11 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-196.brq.redhat.com [10.40.204.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 172835D9C9;
        Fri,  3 Jan 2020 11:19:09 +0000 (UTC)
Date:   Fri, 3 Jan 2020 12:19:07 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Leah Neukirchen <leah@vuxu.org>
Cc:     util-linux@vger.kernel.org, J William Piggott <elseifthen@gmx.com>
Subject: Re: cal -w and ISO weeks
Message-ID: <20200103111907.t443higm4rdzw6xl@10.255.255.10>
References: <87fth2ark3.fsf@vuxu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fth2ark3.fsf@vuxu.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Dec 30, 2019 at 02:09:16PM +0100, Leah Neukirchen wrote:
> So, to avoid further confusion, I'd propose to:
> 
> 1) Reword the description of -w in the man page cal(1).

Fixed (we already have a note about it in NOTES section, but it's
somehow pretty hidden at the first glance).
https://github.com/karelzak/util-linux/commit/261cf856277f5e7e4815c211fe48b97746d5d3a3
 
> 2) Rethink if --iso shouldn't also imply -m, as implied by ISO-8601.

Good point, sounds like user-friendly change (although it is not 100%
backwardly compatible).

William, what about to automatically use -m (start week at Monday)
when --iso specified on command line? It means not keep --iso only
as way to switch calendars, but also as a general option to get 
ISO-8601. (Not sure, may be we already discussed this years ago.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

