Return-Path: <SRS0=I8Gw=ZE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2229C43331
	for <util-linux@archiver.kernel.org>; Tue, 12 Nov 2019 08:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1309204FD
	for <util-linux@archiver.kernel.org>; Tue, 12 Nov 2019 08:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dt2ixLJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKLI6i (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 Nov 2019 03:58:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30855 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725954AbfKLI6i (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 12 Nov 2019 03:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573549117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WHR7ditSBtm9d/0uwm7yItEUWm2fno3nmpPBQXTLY+M=;
        b=dt2ixLJJbUr1PQcuILmvVXV5mqLfJCuqlyEK8t8dD90J17Ps+K6W5y0qJyraOVKpvW2XBk
        /pEshP0yYHn9exjjP4AOC6pQexKvwcS+p578MYTn4k6CFwNflWJIdhd4juLfplfHGdN+tx
        vQDTsvpXNyWfvHyhrTKYPh4RPiNt4Ls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-2mMxhZ8APF29GQ78bBgbfg-1; Tue, 12 Nov 2019 03:58:34 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 137998C699F;
        Tue, 12 Nov 2019 08:58:33 +0000 (UTC)
Received: from 10.255.255.10 (unknown [10.40.205.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 252D89F5C;
        Tue, 12 Nov 2019 08:58:31 +0000 (UTC)
Date:   Tue, 12 Nov 2019 09:58:29 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] blkid: open device in nonblock mode.
Message-ID: <20191112085829.jsgr3guy2tc7sudo@10.255.255.10>
References: <20191104202315.4879-1-msuchanek@suse.de>
 <20191105114122.o3cjzfnoy3hp2rbm@10.255.255.10>
 <20191105171357.GV1384@kitsune.suse.cz>
 <20191106080256.GA19254@kitsune.suse.cz>
 <20191106084833.nx3agnj36brw7i42@10.255.255.10>
 <CADxRZqxToUUgwR4DqEnS84TBQ7y8hy+s0fBoZYn3_Q-Zit1Ktg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CADxRZqxToUUgwR4DqEnS84TBQ7y8hy+s0fBoZYn3_Q-Zit1Ktg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 2mMxhZ8APF29GQ78bBgbfg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 12, 2019 at 11:27:28AM +0300, Anatoly Pugachev wrote:
> On Wed, Nov 6, 2019 at 11:52 AM Karel Zak <kzak@redhat.com> wrote:
> >> On Wed, Nov 06, 2019 at 09:02:56AM +0100, Michal Such=E1nek wrote:
> > > > First off you need to explain it to all authors of all random scrip=
ts
> > > > out there.
> >
> > That's what I'm doing for years :)
>=20
> considering lsblk / findmnt , how they are supposed to replace blkid
> in the following example (taken from os-prober):
>=20
>                 output=3D"$(blkid -o device -t LABEL=3D"$1")" || return 1
>=20
> i wasn't able to find lsblk alternative to match things (label, uuid,
> partition, whatever) - maybe i just don't carefully read manual page
> for it ? Of course it is possible to use grep in pipe after lsblk, but
> anyway.

Yes, it's UN*X :-) ... grep or so

    lsblk -rpo LABEL,NAME | awk '/'$1'/ { print $2 }'


 Karel

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

