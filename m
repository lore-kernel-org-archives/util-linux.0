Return-Path: <SRS0=Vf/c=Y6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F884C5DF62
	for <util-linux@archiver.kernel.org>; Wed,  6 Nov 2019 09:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F582075C
	for <util-linux@archiver.kernel.org>; Wed,  6 Nov 2019 09:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0/0eO0G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfKFJAq (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:00:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27026 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfKFJAq (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 Nov 2019 04:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573030845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LwJ+9cj0iVz3pl/eDHyHrqryqmVRXo4L4tw6d0OWDgk=;
        b=V0/0eO0GYN0D2RjkpfFAgKwjHVG+doLib32ufzNHtHnjy8sXnhTN7i47zfbDTr80w8Iogx
        Pua46SSDC3MRUefJwuJWh+7qX22oAQ6T8Ef8TxmmfRtdXoOOFG42wWg4MiOdJkLHwrNWPi
        +WKaNn9q2GKTc/yBIB/AhNdehB9cJ78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-0ij3T5cdM4iI04TkmK3GHQ-1; Wed, 06 Nov 2019 04:00:42 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1737A1005500;
        Wed,  6 Nov 2019 09:00:42 +0000 (UTC)
Received: from 10.255.255.10 (unknown [10.40.205.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52278600C4;
        Wed,  6 Nov 2019 09:00:41 +0000 (UTC)
Date:   Wed, 6 Nov 2019 10:00:38 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: open device in nonblock mode.
Message-ID: <20191106090038.sogn3fawat7dpz4x@10.255.255.10>
References: <20191104202315.4879-1-msuchanek@suse.de>
MIME-Version: 1.0
In-Reply-To: <20191104202315.4879-1-msuchanek@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 0ij3T5cdM4iI04TkmK3GHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Nov 04, 2019 at 09:23:15PM +0100, Michal Suchanek wrote:
>  libblkid/src/verify.c | 2 +-
>  misc-utils/blkid.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, but I have also added O_NONBLOCK to another places in the
library and to wipefs.

Note that we still use it without O_NONBLOCK in libfdisk, mkswap and
partx ... but I guess it's no so big problem as the primary goal are
scripts with blkid(8).

Thanks.

    Karel

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

