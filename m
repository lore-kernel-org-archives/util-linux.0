Return-Path: <SRS0=Zjrq=Y5=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE89DC010A3
	for <util-linux@archiver.kernel.org>; Tue,  5 Nov 2019 11:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2D7217F5
	for <util-linux@archiver.kernel.org>; Tue,  5 Nov 2019 11:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eP0ymNr6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbfKELla (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 5 Nov 2019 06:41:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45682 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730627AbfKELl3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 5 Nov 2019 06:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572954088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qe9RafiOqE4fcHlwMTbP/XBzqrwAsfKRF7jm2NuaCb8=;
        b=eP0ymNr66OW220L2ipz+3nOuv/W//GEGRnpDrt0oJ7RGkA3zsza4639cQT4p3ADtmNJ780
        NXvFpDXzqAaSXuI5PJcaWAHuDH5x2SER3RBgFT4zPRCd1bVUf6+XMQhf5MSPdM5e/kB3mX
        EsKYZNFDhPAdsTrr9+bEemGBraaaVJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-ZwPpjEEPMNypngQoG5rXWQ-1; Tue, 05 Nov 2019 06:41:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 220101005500;
        Tue,  5 Nov 2019 11:41:26 +0000 (UTC)
Received: from 10.255.255.10 (unknown [10.40.205.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E2F55D70D;
        Tue,  5 Nov 2019 11:41:25 +0000 (UTC)
Date:   Tue, 5 Nov 2019 12:41:22 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: open device in nonblock mode.
Message-ID: <20191105114122.o3cjzfnoy3hp2rbm@10.255.255.10>
References: <20191104202315.4879-1-msuchanek@suse.de>
MIME-Version: 1.0
In-Reply-To: <20191104202315.4879-1-msuchanek@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ZwPpjEEPMNypngQoG5rXWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Nov 04, 2019 at 09:23:15PM +0100, Michal Suchanek wrote:
> When autoclose is set (kernel default but many distributions reverse the
> setting) opening a CD-rom device causes the tray to close.
>=20
> The function of blkid is to report the current state of the device and
> not to change it. Hence it should use O_NONBLOCK when opening the
> device to avoid closing a CD-rom tray.

I can imagine this as optional solution (command line option), but I
have doubts to use O_NONBLOCK by default for all block devices. I have
no example, but it sounds like a way how to introduce regressions in
libblkid behavior. (Any kernel guy around?) Is it really only cdrom
driver(s) where O_NONBLOCK has any impact? What about USB, some random
SCSI, ... I don't know.

The another problem is that the library does not have to open the device,
you can use already open file descriptor (blkid_probe_set_device()).=20
So, in many cases the patch will have no effect.

> blkid is used liberally in scripts so it can potentially interfere with
> the user operating the CD-rom hardware.

It's better to use lsblk in script, it reads info from udev -- call
blindly blkid(8) is usually overkill.

    Karel


--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

