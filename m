Return-Path: <SRS0=fv9v=3Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBF9C2D0DB
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 13:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4646E2071E
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 13:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C16YzAFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgA0Nep (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Jan 2020 08:34:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48080 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgA0Neo (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 27 Jan 2020 08:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580132083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5p049s29ChDMRXF1b4pGj1MvV9S58JjLw9UTEJVky4E=;
        b=C16YzAFuBV6ZbyCs+JaYgjNujdnB0bnv3wFYVLJPz2REoMsS4XjRbya6toKlRVgRsGMs/J
        aylet4Wd07i0VjjltJICERH4+3BFB7qkbvwtTxItqxL3oR4ZJIt/0CPTozxGY6T/jmflmD
        R9hr/FGLl0OSLNWUqVgKKs3hb++jJvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-xhbAN7RhMeC-sclpKkWuuA-1; Mon, 27 Jan 2020 08:34:39 -0500
X-MC-Unique: xhbAN7RhMeC-sclpKkWuuA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF7E0800D41;
        Mon, 27 Jan 2020 13:34:38 +0000 (UTC)
Received: from ws.net.home (ovpn-204-202.brq.redhat.com [10.40.204.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C7BF1001B39;
        Mon, 27 Jan 2020 13:34:37 +0000 (UTC)
Date:   Mon, 27 Jan 2020 14:34:35 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Carlos Santos <unixmania@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.35
Message-ID: <20200127133435.tcnhf23yhi3laphp@ws.net.home>
References: <20200121105711.zzeeolydlivqnik7@ws.net.home>
 <CAJ4jsadjw3xXbrqjsB9cwv_iwodfHWJ4CnhD4oXW_Lvwh0W8XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ4jsadjw3xXbrqjsB9cwv_iwodfHWJ4CnhD4oXW_Lvwh0W8XQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jan 24, 2020 at 04:16:47PM -0300, Carlos Santos wrote:
> I noticed that it comes due to sys-utils/hwclock-parse-date.y, which
> was taken from gnulib. Would it be possible to take the file from an
> previous version of gnulib that was still under GPLv2?

I have checked it again and all history of the file in git is with v3,
and import old version also means import many bugs....

Maybe the best would be to use our lib/timeutils.c:parse_timestamp().
It does not provide support for so many date-time formats, but the
basic format like "2012-09-22 16:34:22" (and subsets) is supported. 

IMHO it's better to introduce a small backward compatibility issue than
rely on hwclock-parse-date.y or execute date(1) like old versions.

I didn't expect v3 to be a problem for so many our users.... ;-(

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

