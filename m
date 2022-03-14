Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AD4C433F5
	for <util-linux@archiver.kernel.org>; Mon, 14 Mar 2022 09:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbiCNJ3I (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 14 Mar 2022 05:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbiCNJ3I (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 14 Mar 2022 05:29:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AB1017AAE
        for <util-linux@vger.kernel.org>; Mon, 14 Mar 2022 02:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647250078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7ZXFMfDXNhaOqkkKqe/NEw01MOMRSYgPc9h72JzHoM=;
        b=i/4G4dvLycPNPAzbdz0z+spwnu9+7EYXkOZ3khkv5iIZEcdsr7nb6FxvCvyUb1J8Bo6Ntg
        w6U63h59phNJuNg3TWPGUrQ82H1fFrLTK29V/Yk74RlrHTqOeUEiRXM4SUYeJI5N24SEg6
        ODHkYMomvxN92DlSKB/G++v/AUOuv9s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-jWa2pyV-MrGf_MTOfRgZmg-1; Mon, 14 Mar 2022 05:27:54 -0400
X-MC-Unique: jWa2pyV-MrGf_MTOfRgZmg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F421803D63;
        Mon, 14 Mar 2022 09:27:54 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E656D4047D19;
        Mon, 14 Mar 2022 09:27:53 +0000 (UTC)
Date:   Mon, 14 Mar 2022 10:27:51 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Benno Schulenberg <bensberg@telfort.nl>
Cc:     util-linux@vger.kernel.org
Subject: Re: the localized output of 'hardlink' is misaligned for some
 languages
Message-ID: <20220314092751.i6rtkm7hxze5lvnb@ws.net.home>
References: <ece4e3d9-7cf7-2319-ec69-de978ab7081e@telfort.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ece4e3d9-7cf7-2319-ec69-de978ab7081e@telfort.nl>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Mar 13, 2022 at 12:24:51PM +0100, Benno Schulenberg wrote:
> After applying the posted localization patch for 'hardlink', the
> localized output is misaligned for some languages.  For example:
> 
> $ LANGUAGE=pl hardlink --dry  ~/Programoj
> Właściwości:           próba
> Method:                   sha256
> Plików:                  8141
> Dowiązano:               2238 files
> Porównano:               0 xattrs
> Porównano:               2255 files
> Oszczędzono:             9,52 MiB
> Trwało:                  0.154945 seconds
> 
> It seems that for calculating the placement of the second column, it
> counts the number of bytes in the word+colon thing and then subtracts
> that from 25 to determine the number of needed padding spaces.  But it
> should count the number of character columns instead.
> 
> Probably this should use libsmartcols in some way?

I'd suggest to ignore this problem for now. libsmartcols is probably
overkill for this small output. I'll debug and fix it later. Thanks.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

