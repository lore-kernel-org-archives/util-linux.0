Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1264EC433C1
	for <util-linux@archiver.kernel.org>; Fri, 26 Mar 2021 10:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF18161A13
	for <util-linux@archiver.kernel.org>; Fri, 26 Mar 2021 10:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhCZKjW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 26 Mar 2021 06:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36026 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbhCZKi7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 26 Mar 2021 06:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616755138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ERAnqPjQUDpPinqYR4pkAIOuXrHp9M1GrFqDuFKw8U4=;
        b=XunFtbjplW7DuCP1FF914FN1pcjpKpOfjPDtg9uFUWMTqKUS/OYAn/MfHiP/UPIfzaBLmu
        irtl4qewJMIbo7H26BIiZrAZ8pAfTuWxFXANqdzDrdikj3j3uGeHLgord/JQrgmpNWuUEv
        57Zf9vzCagcMJqKxRntlvWsptbsChRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-_rmANVNHOlScaeuQ_Kkb9g-1; Fri, 26 Mar 2021 06:38:54 -0400
X-MC-Unique: _rmANVNHOlScaeuQ_Kkb9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6F04107BA56;
        Fri, 26 Mar 2021 10:38:53 +0000 (UTC)
Received: from ws.net.home (ovpn-115-34.ams2.redhat.com [10.36.115.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0247136807;
        Fri, 26 Mar 2021 10:38:52 +0000 (UTC)
Date:   Fri, 26 Mar 2021 11:38:50 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Mario =?utf-8?Q?Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: Help needed with man page conversions to asciidoc?
Message-ID: <20210326103850.76r27yrk3fdaqnbs@ws.net.home>
References: <karelzak/util-linux/issues/1257@github.com>
 <karelzak/util-linux/issues/1257/792670506@github.com>
 <CAHi0vA-d7EQostbdDMZGmKeNfLYvjUWkuvF01nw-CM9wOkWMow@mail.gmail.com>
 <20210309084908.izmuxsrqujiml6ph@ws.net.home>
 <CAHi0vA-SAQYJraWb6ZH5bTWcoGdXMKnHj7fVARRzJN_LpPGc9A@mail.gmail.com>
 <CAHi0vA_Nk4GqS=gYCzwqqRoNPQLH2n9BtLozWgwaQ78MsBvVNg@mail.gmail.com>
 <20210323092705.uaa2oas3ux5s3er7@ws.net.home>
 <CAHi0vA_FL744Lap_GqkrhPPf_wK0BW2Ed_R2FVwQ+L_A4AJdHg@mail.gmail.com>
 <CAHi0vA-OcifUioLiUXSg9UmaMNUzfLhwg+tfm0hFnXYipOq0DQ@mail.gmail.com>
 <20210326102518.ex4t7kj6chswe7du@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326102518.ex4t7kj6chswe7du@ws.net.home>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Mar 26, 2021 at 11:25:22AM +0100, Karel Zak wrote:
> The issue is that we have the link pages in the dist_man_MANS=
> and 'make' tries to verify the link file *before* the  original 
> man page. It means  
> 
>   dist_man_MANS += sys-utils/swapon.8 sys-utils/swapoff.8
> 
> is no problem, but:
> 
>   dist_man_MANS += sys-utils/swapoff.8 sys-utils/swapon.8
> 
> ends with error ;-)
> 
> I'll send you pull request to your topic/asciidoc do fix this (and
> some others minor) issue.

Note that fix it by "right order" in $dist_man_MANS is a poor solution,
because for "make -j" it does not follow the order. The solution we
need is split man pages and man page links to two variables. I'll do
fix it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

