Return-Path: <SRS0=e0jN=25=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EBDC00523
	for <util-linux@archiver.kernel.org>; Wed,  8 Jan 2020 08:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0294B206DB
	for <util-linux@archiver.kernel.org>; Wed,  8 Jan 2020 08:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxIt5XJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgAHIZ7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:25:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57431 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726290AbgAHIZ7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 8 Jan 2020 03:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578471958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5aeygQL3UT1k4HDrQae4VVZFmZ2YBAC1Wf9E5TkKQY=;
        b=gxIt5XJ9kXydaMnmlhYzH8j+7OC3QORfpV5BE//wVRVTj3k47pJLxy5lbnZyLYCVokxTcG
        qll/IOGcu4aCoi4nJbbGx3MT+rcAd+5lnQuaFzUFgbRuiEA93axWD1UFVpxwDgh0vJdzaK
        ZGM70EzGVzA1ff7sH6M6xerPaZnC/MM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-Hyf1cJ43POKIZU6VZi9jQg-1; Wed, 08 Jan 2020 03:25:57 -0500
X-MC-Unique: Hyf1cJ43POKIZU6VZi9jQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B852800D50;
        Wed,  8 Jan 2020 08:25:56 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-196.brq.redhat.com [10.40.204.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 698D660E1C;
        Wed,  8 Jan 2020 08:25:55 +0000 (UTC)
Date:   Wed, 8 Jan 2020 09:25:52 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: open device in nonblock mode.
Message-ID: <20200108082552.dmofs7fe7624oniv@10.255.255.10>
References: <20191104202315.4879-1-msuchanek@suse.de>
 <20200107160443.y72na25i5fk72zqt@10.255.255.10>
 <20200107161918.GX4113@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20200107161918.GX4113@kitsune.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jan 07, 2020 at 05:19:18PM +0100, Michal Such=E1nek wrote:
> On Tue, Jan 07, 2020 at 05:04:43PM +0100, Karel Zak wrote:
> > On Mon, Nov 04, 2019 at 09:23:15PM +0100, Michal Suchanek wrote:
> > > When autoclose is set (kernel default but many distributions revers=
e the
> > > setting) opening a CD-rom device causes the tray to close.
> >=20
> > I found unwanted side effect, open() with O_NONBLOCK also successes
> > when there is no medium. Unfortunately, we ignore I/O errors for
> > CDROMs to support some crazy hybrid media -- so overall result is man=
y
> > I/O warnings in system logs.
> >=20
> > I have added CDROM_DRIVE_STATUS to the logic to stop probing when
> > there is no medium. Let's hope it will be enough:
> >=20
> > https://github.com/karelzak/util-linux/commit/dc30fd4383e57a0440cdb0e=
16ba5c4336a43b290
>=20
> It it probably safer to do
> switch (ioctl(fd, CDROM_DRIVE_STATUS, CDSL_CURRENT)) {
> to support some crazy CD changers.

Good point, I have seen it in kernel docs, but forgot to use it.
Fixed. Thanks for review.

    Karel

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

