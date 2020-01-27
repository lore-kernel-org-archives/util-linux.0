Return-Path: <SRS0=fv9v=3Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBD2C2D0DB
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 15:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB19A2087F
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 15:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCkIHC5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgA0P0D (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:26:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48884 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729321AbgA0P0D (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Jan 2020 10:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580138762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jRE0OXyZFUkg7/3+s8rvhZ3Z5ZpR6/OqW5gQJGaTw9w=;
        b=JCkIHC5XQBDA7ZJ+PJxf6iMS54npovkGSAFzty/r69gwyL7XelIRcyV/xl3yxTff5UoQZa
        So3jSb6Z1ycgsBPp8yh2G9YzojmEQWSugedh+IzJqOGO4xzLfjS8By7qY066q7WAaOQ7Qu
        eSRixz95uStanCKNQj4BrkNLHjkiRYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-3G7M3JQxNhmyQVf8TFBVcQ-1; Mon, 27 Jan 2020 10:26:00 -0500
X-MC-Unique: 3G7M3JQxNhmyQVf8TFBVcQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF913801A09;
        Mon, 27 Jan 2020 15:25:59 +0000 (UTC)
Received: from ws.net.home (ovpn-204-202.brq.redhat.com [10.40.204.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA377863CD;
        Mon, 27 Jan 2020 15:25:58 +0000 (UTC)
Date:   Mon, 27 Jan 2020 16:25:56 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Carlos Santos <unixmania@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.35
Message-ID: <20200127152556.gcxf5t6uxo6qeeit@ws.net.home>
References: <20200121105711.zzeeolydlivqnik7@ws.net.home>
 <CAJ4jsadjw3xXbrqjsB9cwv_iwodfHWJ4CnhD4oXW_Lvwh0W8XQ@mail.gmail.com>
 <20200127133435.tcnhf23yhi3laphp@ws.net.home>
 <20200127134005.qymawlxsf34p4oma@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127134005.qymawlxsf34p4oma@ws.net.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jan 27, 2020 at 02:40:09PM +0100, Karel Zak wrote:
> or we can use #ifdef to keep it backwardly compatible for normal
> distros where v3 is not problem and lib/timeutils.c:parse_timestamp()
> with v2 for the rest ... at least for v2.35.1.

Implemented: https://github.com/karelzak/util-linux/commit/e8c21c894e69ba0c72ecf69e8297cb20ec5f9c1e

Use ./configure --disable-hwclock-gplv3 for your GPLv3-free systems :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

