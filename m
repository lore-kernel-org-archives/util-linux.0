Return-Path: <SRS0=jZQs=ZZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C548C432C0
	for <util-linux@archiver.kernel.org>; Tue,  3 Dec 2019 14:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221F220661
	for <util-linux@archiver.kernel.org>; Tue,  3 Dec 2019 14:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvEoTmSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfLCOnn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:43:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49131 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbfLCOnn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 3 Dec 2019 09:43:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575384222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7baFx2I6V55uRM1PNfta1rV4JUUSL0lQIGkLC2HlePM=;
        b=KvEoTmStmYOQs2vWYCUvcYwlyHdAlVnA219KUvPnGs8O/4Xp0wLceHsy3C+sk6N34J41u4
        OQLStkQTQQs7sbmpISZZNWSxThtbVZlcXEIdjRCMK5aMZiVwNLtsMXp6WdI4BvuNnVWls0
        zhXQgpd0YKSAsxXTllwk/htc94fLU2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-QjhVdht_NnyN9y9IYB5iPQ-1; Tue, 03 Dec 2019 09:43:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2B4118C35AC
        for <util-linux@vger.kernel.org>; Tue,  3 Dec 2019 14:43:39 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-205-135.brq.redhat.com [10.40.205.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 69EEA67E5D
        for <util-linux@vger.kernel.org>; Tue,  3 Dec 2019 14:43:39 +0000 (UTC)
Date:   Tue, 3 Dec 2019 15:43:36 +0100
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Subject: Re: [HEADS-UP]: mount(8) non-root user mount changes
Message-ID: <20191203144336.mwbg5e77epv5buen@10.255.255.10>
References: <20191119143408.b6pcbhtsiubxdcob@10.255.255.10>
MIME-Version: 1.0
In-Reply-To: <20191119143408.b6pcbhtsiubxdcob@10.255.255.10>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: QjhVdht_NnyN9y9IYB5iPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 19, 2019 at 03:34:11PM +0100, Karel Zak wrote:
>  for years users are unhappy with too strict mount/umount rules for
>  non-root users.  The rules makes mount(8) useless for use-cases where
>  root permissions are unnecessary. This patch changes the game.

Merged, we will see... ;-) BTW, I'd like to make -rc1 next week.

    Karel

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

