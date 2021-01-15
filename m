Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC92C433DB
	for <util-linux@archiver.kernel.org>; Fri, 15 Jan 2021 16:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755132339E
	for <util-linux@archiver.kernel.org>; Fri, 15 Jan 2021 16:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbhAOQaS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 Jan 2021 11:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725923AbhAOQaR (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 15 Jan 2021 11:30:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610728131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ktDhOvVGLnvjmbHNk4P59a5QpqEJlEsBA6c4zHoPsBw=;
        b=QHCwEsouCcd0SbXfJ38LmJDoVURXoYzxHcMe2QQUcfbkyWintdWMDOrwHJOwZaBU7pfStf
        JXw0DD7ebkda1v/kpe8Lfk4U6tHKR0uDlK2WMlPDYtUpcK7/Pv2kJ0+ziTNstw8JHoPQ5l
        az/F6pj3RbXPGwQaV1OFTat6FHO8PWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-LuE4LuouNqKG5dSHueg-1Q-1; Fri, 15 Jan 2021 11:28:48 -0500
X-MC-Unique: LuE4LuouNqKG5dSHueg-1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0E65107ACF8;
        Fri, 15 Jan 2021 16:28:46 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C282620DE;
        Fri, 15 Jan 2021 16:28:46 +0000 (UTC)
Date:   Fri, 15 Jan 2021 17:28:43 +0100
From:   Karel Zak <kzak@redhat.com>
To:     "Michael T. Kloos" <michael@michaelkloos.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: FAT12 format does not honor the -R option
Message-ID: <20210115162843.kwxrwgfe2wxght72@ws.net.home>
References: <abf8a4c7-fa0c-6e2b-e272-e68531ede173@michaelkloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abf8a4c7-fa0c-6e2b-e272-e68531ede173@michaelkloos.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jan 15, 2021 at 11:01:45AM -0500, Michael T. Kloos wrote:
> "mkfs.vfat -F 12 -R 2 /dev/loop0" does not seem to honor the -R option. 

For mkfs.vfat see https://github.com/dosfstools/dosfstools. It's not
maintained by util-linux project.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

