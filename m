Return-Path: <SRS0=GjY+=3T=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53B7C33C9E
	for <util-linux@archiver.kernel.org>; Thu, 30 Jan 2020 11:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69D6206D5
	for <util-linux@archiver.kernel.org>; Thu, 30 Jan 2020 11:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bz6F8i8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgA3LSE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:18:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36616 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726902AbgA3LSE (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 30 Jan 2020 06:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580383083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eVyPCM7mFWD3RbQddbOe0QEoIZoRG64qweejHuGq1pg=;
        b=Bz6F8i8RKLuye0+m7v+2bPBlgRr14ZI9Vclmmc+gjhc1+yQGuKAvU4qTs1NCkCrigR2WcI
        qewG/VVYHC8DSyhXur6txNCz2fesd/mugUBT9rbb9Lpbixz/y0iFA9NkRkJqKMDy5IVhYM
        PcbLY8Rp/azm0yksU2jxC/I5JtKlvtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-271lEOifNz-yomgx6l81gQ-1; Thu, 30 Jan 2020 06:17:57 -0500
X-MC-Unique: 271lEOifNz-yomgx6l81gQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7B3710054E3;
        Thu, 30 Jan 2020 11:17:56 +0000 (UTC)
Received: from ws.net.home (ovpn-204-202.brq.redhat.com [10.40.204.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA07419E9C;
        Thu, 30 Jan 2020 11:17:55 +0000 (UTC)
Date:   Thu, 30 Jan 2020 12:17:53 +0100
From:   Karel Zak <kzak@redhat.com>
To:     kerolasa@gmail.com
Cc:     Carlos Santos <unixmania@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [ANNOUNCE] util-linux v2.35
Message-ID: <20200130111753.moen7ulzaz2jc5fh@ws.net.home>
References: <20200121105711.zzeeolydlivqnik7@ws.net.home>
 <CAJ4jsadjw3xXbrqjsB9cwv_iwodfHWJ4CnhD4oXW_Lvwh0W8XQ@mail.gmail.com>
 <20200127133435.tcnhf23yhi3laphp@ws.net.home>
 <20200127134005.qymawlxsf34p4oma@ws.net.home>
 <CAJ4jsafKGLntP-uKj-+kVY=xGk9FTPuw98ntsAEEpMFR8Ub6zQ@mail.gmail.com>
 <20200127202152.4jh2w4chch37wgee@ws.net.home>
 <CAG27Bk0K-p+9eqUp8H+=-qrUuaEeiSHHsj7t9BA+fyRAwfVY3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG27Bk0K-p+9eqUp8H+=-qrUuaEeiSHHsj7t9BA+fyRAwfVY3Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jan 28, 2020 at 07:24:13PM +0000, Sami Kerola wrote:
> On Mon, 27 Jan 2020 at 20:22, Karel Zak <kzak@redhat.com> wrote:
> > No, it's really simple digits based date-time like "2012-09-22 16:34:22".
> >
> > getdate(3) is maybe another choice for future versions, for 2.35.1 is
> > parse_timestamp() good enough to avoid GPLv3.
> 
> This will most likely end up causing an ABI breakage so I think the best
> option is the least complicated time format, that is what parse_timestamp()
> provides.

IMHO current solution with #ifdefs is good enough for mainstream
hwclock users, the minority with gplv3-free requirement has to be more
careful with date/time formats... We need to describe it in the man
page and add some advice for portability, because the current
situation ("we support whatever format") is horrible commitment for
future.

Anyway, extend parse_timestamp() to support month and day names would
be nice for another tools too.

> In case arbitrary format really must be supported then I think the best
> option is to parse_timestamp() and if that fails call getdate() as well.

or add getdate() as the last possibility in parse_timestamp() :-)

> That said I have no idea how to write instructions to manual page about
> DATEMSK environment variable and strptime() formats without causing
> new-to-linux users to wonder why simple things must be so hard.

Good point. Frankly I have never seen getdate() in any code and for
good reasons coreutils guys replaced this function by own code.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

