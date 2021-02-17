Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA29C433DB
	for <util-linux@archiver.kernel.org>; Wed, 17 Feb 2021 08:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3D364D7F
	for <util-linux@archiver.kernel.org>; Wed, 17 Feb 2021 08:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhBQICT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 17 Feb 2021 03:02:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230145AbhBQICT (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 Feb 2021 03:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613548853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IoItTRwWbCKCx3FWM9DGhPAniIUgvsU18AULC5pdKjk=;
        b=ByVRKr6W60qHyhAZUN5VuxMyp63n0oPeuA9B1XOy1drBgmDQv/CEQFinf/Mp3WX/Xw9ELV
        3d8VktMhHQw5L8EoQy4hbO2pXX5FHIH6p1lAWvXz40Z5RtFLHo05rLjFi71aPTGqiZYhvU
        5CfF5ZbRsr0u4WJZJV9V1B43/gM5Ylw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-svovLJBWOpKLTDRBUMgpvQ-1; Wed, 17 Feb 2021 03:00:46 -0500
X-MC-Unique: svovLJBWOpKLTDRBUMgpvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46F1D1936B60;
        Wed, 17 Feb 2021 08:00:45 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F885722C9;
        Wed, 17 Feb 2021 08:00:44 +0000 (UTC)
Date:   Wed, 17 Feb 2021 09:00:41 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc:     util-linux@vger.kernel.org
Subject: Re: meson build-system
Message-ID: <20210217080041.jygdgvf4jtulqmqd@ws.net.home>
References: <20210216180030.a3pdnbcm3ps6dqmi@ws.net.home>
 <20210216201925.GW7348@in.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210216201925.GW7348@in.waw.pl>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Feb 16, 2021 at 08:19:25PM +0000, Zbigniew Jędrzejewski-Szmek wrote:
> > The goal is to try to provide an alternative, make it more stable,
> > and maybe in future use it. The current util-linux meson configuration is 
> > probably not mature enough to be used as a build-system for end-users and
> > downstream distributions, but it seems as a nice alternative for
> > developers, it's faster and it produces real binaries rather than
> > libtool scripts.
> 
> Eh, I'd say that at this point meson (despite occasional small tweaks
> required) is more stable than autotools.

I have talked about "current util-linux meson configuration", not
about meson itself. We need to test our stuff better, make sure all
the configuration options works as expected, etc.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

