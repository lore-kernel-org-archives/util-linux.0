Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44CBC432BE
	for <util-linux@archiver.kernel.org>; Thu,  2 Sep 2021 11:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E7D60F56
	for <util-linux@archiver.kernel.org>; Thu,  2 Sep 2021 11:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbhIBLDy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 2 Sep 2021 07:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232113AbhIBLDw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 2 Sep 2021 07:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630580573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r0jh9araE1N7umec6/n2EWp0uVe87mbnFlAk93a6ObQ=;
        b=NdcCiK6/kVCvUqqJHhKPpe16pzfvTrHZIgGKPSvY7E8Mc38mJnENY5UyI/S8sIIsBTyFAZ
        +eoHxNVRrEikeefmWUllp6VDyaA/9s4/2mvK7URpeXMeFFwOaxooEz7JfarfdZ/73v5CPY
        bjF0PvEtvE8wVJB8hYqEBSszxgfh+yA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-sCsX2W6-Omuds98JTaylYA-1; Thu, 02 Sep 2021 07:02:52 -0400
X-MC-Unique: sCsX2W6-Omuds98JTaylYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 898F2196632F;
        Thu,  2 Sep 2021 11:02:51 +0000 (UTC)
Received: from ws.net.home (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DEA405DF2F;
        Thu,  2 Sep 2021 11:02:50 +0000 (UTC)
Date:   Thu, 2 Sep 2021 13:02:48 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Update translations in Translation Project
Message-ID: <20210902110248.yhx6bolnitqsmlo6@ws.net.home>
References: <CAFPa+S=yR41168UsfjoJ1NshK_EfAbrdpgmJiEy-Yzd6rEW14A@mail.gmail.com>
 <CAHi0vA-2YpvY053tnh=-=VQeWPJd2FSM5Tk1Y3wtGz=9aNz1WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHi0vA-2YpvY053tnh=-=VQeWPJd2FSM5Tk1Y3wtGz=9aNz1WQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Sep 01, 2021 at 07:11:10PM +0200, Mario Blättermann wrote:
> Hello Rafael,
> 
> Am Mi., 1. Sept. 2021 um 18:34 Uhr schrieb Rafael Fontenelle
> <rafaelff@gnome.org>:
> >
> > Hi there,
> >
> > Translation Project has util-linux-man domain POT in version 2.37-rc2,
> > and it seems that a few strings are different from released 2.37.
> > Please consider updating the POT version on the Translation Project to
> > avoid losing translation effort.
> >
> The slightly outdated template at GNU TP will be updated with version
> 2.38 of util-linux (@Karel, any plans for the next release...?).

My wish is to have 4-6 months between releases (ideally 4 months), so
it would be nice to have v2.38 in October.

> Regarding the import of the current translations from manpages-l10n:
> I'm almost finished with French and Spanish. The Dutch and Polish
> files I already sent to the respective mailing lists, but haven't got
> an answer yet. Regardless of the presence of the mentioned languages
> at the util-linux-man TP domain, I would say we should activate the
> man page translations with the next release.

Cool, I'm looking forward to another battle with autotools :-)))

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

