Return-Path: <SRS0=Vf/c=Y6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE0BC5DF62
	for <util-linux@archiver.kernel.org>; Wed,  6 Nov 2019 08:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CABA206A3
	for <util-linux@archiver.kernel.org>; Wed,  6 Nov 2019 08:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXVow2VY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfKFIsl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Nov 2019 03:48:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56017 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730178AbfKFIsl (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 Nov 2019 03:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573030120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AxW9xoMiyfUVN3zQflyIFe2Fsq0ARDGmes6nV9PkxCE=;
        b=TXVow2VY9R8N6xy1ILWApprWB9D2t66Tu3qSxMUT0VnJ3RvBb5/vSUHQQ8+mmxa4lj2+7r
        gtR7rUNV7AzrNC1ODFD+tYYuiHyAKXhUk9Zgzy6tqV2CxfkyIaDuxj6jDSzlC55/8ZJbSc
        Er2OpKYKZxe63xamRGFDSKGmgx7z/PQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-9yxJqgtXME6Od8SsX1xfqg-1; Wed, 06 Nov 2019 03:48:37 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FA158017E0;
        Wed,  6 Nov 2019 08:48:36 +0000 (UTC)
Received: from 10.255.255.10 (unknown [10.40.205.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 912275D9CD;
        Wed,  6 Nov 2019 08:48:35 +0000 (UTC)
Date:   Wed, 6 Nov 2019 09:48:33 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: open device in nonblock mode.
Message-ID: <20191106084833.nx3agnj36brw7i42@10.255.255.10>
References: <20191104202315.4879-1-msuchanek@suse.de>
 <20191105114122.o3cjzfnoy3hp2rbm@10.255.255.10>
 <20191105171357.GV1384@kitsune.suse.cz>
 <20191106080256.GA19254@kitsune.suse.cz>
MIME-Version: 1.0
In-Reply-To: <20191106080256.GA19254@kitsune.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 9yxJqgtXME6Od8SsX1xfqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Nov 06, 2019 at 09:02:56AM +0100, Michal Such=E1nek wrote:
> > If some random program using libblkid closes the tray I don't care that
> > much. However, many system scripts use blkid, probably to find a device

One of the random programs is udev:

   src/udev/udev-builtin-blkid.c:

       fd =3D open(devnode, O_RDONLY|O_CLOEXEC);
       if (fd < 0)
               return log_device_debug_errno(dev, errno, "Failed to open bl=
ock device %s: %m", devnode);

       errno =3D 0;
       r =3D blkid_probe_set_device(pr, fd, offset, 0);

> > First off you need to explain it to all authors of all random scripts
> > out there.

That's what I'm doing for years :)

Anyway, I'm going to apply the patch, thanks for your investigation.

Let's hope it will not introduce any change on something else than
on cdroms and floppies.

    Karel

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

