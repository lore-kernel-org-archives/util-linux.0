Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2135BC4338F
	for <util-linux@archiver.kernel.org>; Wed, 25 Aug 2021 10:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0496261076
	for <util-linux@archiver.kernel.org>; Wed, 25 Aug 2021 10:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhHYKEG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 25 Aug 2021 06:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54992 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239734AbhHYKEE (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 25 Aug 2021 06:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629885799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E2/SH/sqHDLJInw43M2sGe6A4p6GwCWL8sYvt3eqAxM=;
        b=ifmWeRenvjLDdSuGatBsu3nXjwRjKMO7kbicCPZfI8vevsGa77INbS838W17s6PfymI64e
        7fSHwYzg2Ym5joqlMmg1o3RlO2dkQisxIMWUfGSgsl0Z5hXjo3IV9li/iFPo6UlrM99pA7
        KxE4ptrj4r6Nu1XEHx8keLaLuOD2wKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-aaIUj1hXOpy396FKGK3Jiw-1; Wed, 25 Aug 2021 06:03:17 -0400
X-MC-Unique: aaIUj1hXOpy396FKGK3Jiw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FDAC101C8A0;
        Wed, 25 Aug 2021 10:03:16 +0000 (UTC)
Received: from ws.net.home (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDC955D9C6;
        Wed, 25 Aug 2021 10:03:15 +0000 (UTC)
Date:   Wed, 25 Aug 2021 12:03:12 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 0/2] add columns for zoned parameters
Message-ID: <20210825100312.36dktmaizhk6vups@ws.net.home>
References: <20210824011718.300747-1-naohiro.aota@wdc.com>
 <20210824124729.or5nyoadc3fbla2y@ws.net.home>
 <20210825021227.xwt3xl2c3kbmosjb@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825021227.xwt3xl2c3kbmosjb@naota-xeon>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Aug 25, 2021 at 02:12:27AM +0000, Naohiro Aota wrote:
> > > $ lsblk --help|grep -i zone
> > >  -z, --zoned          print zone model
> > >         ZONED  zone model
> > >     ZONE-SIZE  zone size
> > >    ZONE-WGRAN  zone write granularity
> > >   ZONE-APPEND  zone append max bytes
> > >      ZONES-NR  number of zones
> > >    ZONES-OMAX  max open zones
> > >    ZONES-AMAX  max active zones
> > 
> > It would be nice to have shorter column names, but I do not have any
> > sane suggestion (Z-SIZE or Z-APPEND seems strange).
> 
> Hmm, considering we already have DISC-{ALN,GRAN,MAX,ZERO}, how about
> ZONE-{SZ,GRAN,APP,NR,OMAX,AMAX}?

 Sounds good.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

