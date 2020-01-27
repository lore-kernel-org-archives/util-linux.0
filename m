Return-Path: <SRS0=fv9v=3Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F9AC2D0DB
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 20:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C5824679
	for <util-linux@archiver.kernel.org>; Mon, 27 Jan 2020 20:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACn1msyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgA0UWG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:22:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55332 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726101AbgA0UWF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 27 Jan 2020 15:22:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580156524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zD2PiFmUmv3yMzyy3kDtF0etdxCj78+HX3R2UocR6K8=;
        b=ACn1msyQb4uJQiZbZdoaFVK/nh7Dk+zmr6xe4EqUwO0heAD14rLOOg+cAZ1fHNIeodOhkp
        OpZOddJXspk2tth/IyYQd4mFUDVBxhIbtot6AzoQMP8gguKidWLIcf1gFBnvB4XcimMObo
        DrR3xNoULl4sNFOTdQb8en+8VBpCKRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-JmiMYlWTNGqn9cpr5tUYdw-1; Mon, 27 Jan 2020 15:21:56 -0500
X-MC-Unique: JmiMYlWTNGqn9cpr5tUYdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D45F800EBB;
        Mon, 27 Jan 2020 20:21:55 +0000 (UTC)
Received: from ws.net.home (ovpn-204-202.brq.redhat.com [10.40.204.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE8D1381;
        Mon, 27 Jan 2020 20:21:54 +0000 (UTC)
Date:   Mon, 27 Jan 2020 21:21:52 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Carlos Santos <unixmania@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.35
Message-ID: <20200127202152.4jh2w4chch37wgee@ws.net.home>
References: <20200121105711.zzeeolydlivqnik7@ws.net.home>
 <CAJ4jsadjw3xXbrqjsB9cwv_iwodfHWJ4CnhD4oXW_Lvwh0W8XQ@mail.gmail.com>
 <20200127133435.tcnhf23yhi3laphp@ws.net.home>
 <20200127134005.qymawlxsf34p4oma@ws.net.home>
 <CAJ4jsafKGLntP-uKj-+kVY=xGk9FTPuw98ntsAEEpMFR8Ub6zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ4jsafKGLntP-uKj-+kVY=xGk9FTPuw98ntsAEEpMFR8Ub6zQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jan 27, 2020 at 01:29:47PM -0300, Carlos Santos wrote:
> On Mon, Jan 27, 2020 at 10:40 AM Karel Zak <kzak@redhat.com> wrote:
> >
> > On Mon, Jan 27, 2020 at 02:34:38PM +0100, Karel Zak wrote:
> > > On Fri, Jan 24, 2020 at 04:16:47PM -0300, Carlos Santos wrote:
> > > > I noticed that it comes due to sys-utils/hwclock-parse-date.y, which
> > > > was taken from gnulib. Would it be possible to take the file from an
> > > > previous version of gnulib that was still under GPLv2?
> > >
> > > I have checked it again and all history of the file in git is with v3,
> > > and import old version also means import many bugs....
> > >
> > > Maybe the best would be to use our lib/timeutils.c:parse_timestamp().
> > > It does not provide support for so many date-time formats, but the
> > > basic format like "2012-09-22 16:34:22" (and subsets) is supported.
> > >
> > > IMHO it's better to introduce a small backward compatibility issue than
> > > rely on hwclock-parse-date.y or execute date(1) like old versions.
> >
> > or we can use #ifdef to keep it backwardly compatible for normal
> > distros where v3 is not problem and lib/timeutils.c:parse_timestamp()
> > with v2 for the rest ... at least for v2.35.1.
> 
> Does parse_timestamp support localization, like getdate(3) does?

No, it's really simple digits based date-time like "2012-09-22 16:34:22".

getdate(3) is maybe another choice for future versions, for 2.35.1 is
parse_timestamp() good enough to avoid GPLv3.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

