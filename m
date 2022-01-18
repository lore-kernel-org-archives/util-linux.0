Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638EEC433EF
	for <util-linux@archiver.kernel.org>; Tue, 18 Jan 2022 11:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbiARLvC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 18 Jan 2022 06:51:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37541 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241090AbiARLvC (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Jan 2022 06:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642506661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dI+ImkypjaLrgcLpbuH3a94HlUO6Q9xvx6dff2xvtqc=;
        b=FNbr1XX2ugUuODa2dAmJ3ZTLQZTTV/JFsTjUOcnusHQS6BFHx513UuTFW9Ujau62zAGzyn
        jIehXVuY2oTLADuU8lA0B/MLktkx2KKSrLivqqHOMl72GwiGDFTNHfEtm/28eRlpF73EoC
        7oaAY+MEnGRSkHox6pHZqunLCTHqPas=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-28PD99pnMYC2PtyGESokFQ-1; Tue, 18 Jan 2022 06:50:56 -0500
X-MC-Unique: 28PD99pnMYC2PtyGESokFQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06A491937FC4;
        Tue, 18 Jan 2022 11:50:55 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B66578A8D;
        Tue, 18 Jan 2022 11:50:53 +0000 (UTC)
Date:   Tue, 18 Jan 2022 12:50:50 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Daniel Gerber <dg@atufi.org>
Cc:     Sean Anderson <seanga2@gmail.com>, dottedmag@dottedmag.net,
        id@mbekkema.name, jpeach@apache.org, util-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/6] unshare: Add support for mapping ranges of
 user/group IDs
Message-ID: <20220118115050.jccwbz2hk2323lnl@ws.net.home>
References: <20211124182618.1801447-1-seanga2@gmail.com>
 <874k664nlq.fsf@atufi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874k664nlq.fsf@atufi.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jan 14, 2022 at 11:29:21AM +0100, Daniel Gerber wrote:
>  	mem2strcpy(buf, name, sz, sizeof(buf));
> -	return strtoul_or_err(name, _("could not parse ID"));
> +	return strtoul_or_err(buf, _("could not parse ID"));

Should be fixed in git tree. Thanks for your report!

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

