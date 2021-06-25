Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED60FC2B9F4
	for <util-linux@archiver.kernel.org>; Fri, 25 Jun 2021 11:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4AE461490
	for <util-linux@archiver.kernel.org>; Fri, 25 Jun 2021 11:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhFYLam (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 25 Jun 2021 07:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229458AbhFYLam (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 25 Jun 2021 07:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624620501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rw9PPeh+TZjRSNUmH9KefiVqmTE3lwNgCQtFVLr33+w=;
        b=cgHBAigGdQVkGEFMFeQ/eq6W6TaHwqes8RoAM6JP7BVrVoQMfRYL+j6lNsxvL0t4cRXBg+
        MIlIRf/UACWO1v2dK3GEVEMrF4f7F9k0lsrApME18r8GnHUJkKoD83uPmDiwt6C1BVb+iB
        EhUbr53u/VK23sp2MPNk6H1OVmJu22U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-QZPCwg4tO5-qP_IY75micg-1; Fri, 25 Jun 2021 07:28:17 -0400
X-MC-Unique: QZPCwg4tO5-qP_IY75micg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1EA5100C610;
        Fri, 25 Jun 2021 11:28:15 +0000 (UTC)
Received: from ws.net.home (ovpn-112-214.ams2.redhat.com [10.36.112.214])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C93A85D9C6;
        Fri, 25 Jun 2021 11:28:13 +0000 (UTC)
Date:   Fri, 25 Jun 2021 13:28:11 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     util-linux@vger.kernel.org, patches@amperecomputing.com,
        zwang@amperecomputing.com, mas@amperecomputing.com,
        ilkka@os.amperecomputing.com, jeremy.linton@arm.com,
        jbastian@redhat.com, m.mizuma@jp.fujitsu.com,
        patrick.zhang@amperecomputing.com
Subject: Re: [RFC PATCH] lscpu: get more infomation when using
 "/sys/firmware/dmi/entries/4-0/raw"
Message-ID: <20210625112811.lf2eztyp42jdpssf@ws.net.home>
References: <20210621110900.41043-1-shijie@os.amperecomputing.com>
 <20210625092301.6zlyufiwjkta7rf7@ws.net.home>
 <YNWi14N4DToDMlUa@hsj-NUC11PAHi7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNWi14N4DToDMlUa@hsj-NUC11PAHi7>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jun 25, 2021 at 05:33:11PM +0800, Huang Shijie wrote:
> Hi Karel,
> On Fri, Jun 25, 2021 at 11:23:01AM +0200, Karel Zak wrote:
> > 
> > I've lost in your patches :-) 
> > 
> > Your previous patch "[PATCH] lscpu: remove the old code" removes all
> > arm_smbios_decode() as it's unnecessary. This next patch tries to
> > extend arm_smbios_decode().
> I thought you do not like the patch "[PATCH] lscpu: remove the old code".

If I don't like anything then I provide feedback, ignore contributors
in silent way is not polite from my point of view ;-)

I've thought that jbastian and m.mizuma will provide any feedback
about /sys/firmware/dmi/entries/4-0/raw removal from lscpu.

> It is okay that any patch of the two is merged. :)

OK, removed code is a good code. So it seems the first patch is
probably a good idea.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

