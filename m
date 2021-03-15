Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92173C433DB
	for <util-linux@archiver.kernel.org>; Mon, 15 Mar 2021 11:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D13A64DE3
	for <util-linux@archiver.kernel.org>; Mon, 15 Mar 2021 11:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCOLCp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 15 Mar 2021 07:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46689 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229661AbhCOLCb (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 15 Mar 2021 07:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615806151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5qQL9Zd+ZpMBVll9dFpZdhS1xsgoE8kZ88yI7i1+zs=;
        b=W3mBwfuVjqhXynydNt8GkBf/fF6hG3HQfxH/1cgoXfGN4H1L0/RjyNyinpTmBY6hd8AbJ3
        Im/beA+5kcmznojL98sWRvEW53uQqd0+xK43yio+qPsdl23oh/2P6Sc6M6+q9ySSu7eJTu
        CK8pKk9LwOjL0tm3jSQMr5few8GZklk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-4aowmm4mM7uugr4D3qWesQ-1; Mon, 15 Mar 2021 07:02:25 -0400
X-MC-Unique: 4aowmm4mM7uugr4D3qWesQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A82A394EE3;
        Mon, 15 Mar 2021 11:02:24 +0000 (UTC)
Received: from ws.net.home (ovpn-113-171.ams2.redhat.com [10.36.113.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F23785D768;
        Mon, 15 Mar 2021 11:02:23 +0000 (UTC)
Date:   Mon, 15 Mar 2021 12:02:21 +0100
From:   Karel Zak <kzak@redhat.com>
To:     L A Walsh <lkml@tlinx.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: is there a util, or can findmnt be enhanced...(RFE?)
Message-ID: <20210315110221.fpz66zkpwqp6ebva@ws.net.home>
References: <604A8111.8090100@tlinx.org>
 <20210312075543.jei3secawflwrw6b@ws.net.home>
 <604C4427.3040501@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <604C4427.3040501@tlinx.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Mar 12, 2021 at 08:48:39PM -0800, L A Walsh wrote:
> On 2021/03/11 23:55, Karel Zak wrote:
> > $ pwd
> >  /home/projects/util-linux
> > 
> >  $ findmnt --target .
> >  TARGET SOURCE         FSTYPE OPTIONS
> >  /home  /dev/nvme0n1p2 ext4   rw,relatime
> ----
>    Hmmm.  Didn't know about that.  Thanks for the info!  Why does it
> produce no output when a non-mount-point is entered?  I.e. -- is that
> behavior something that is currently relied upon?

Do you mean the default output (when --target is not specified)?

The problem is that findmnt follows mount(8) behavior when search for
filesystem. It means you do not have to be explicit and you can use
source as well as target:

 $ findmnt /dev/sda2
 TARGET SOURCE    FSTYPE OPTIONS
 /boot  /dev/sda2 ext4   rw,relatime

 $ findmnt /boot
 TARGET SOURCE    FSTYPE OPTIONS
 /boot  /dev/sda2 ext4   rw,relatime


and if you try it with device which is not mounted

 $ findmnt /dev/sda3

you get nothing, but the same situation with --target:

 $ findmnt --target /dev/sda3
 TARGET SOURCE   FSTYPE   OPTIONS
 /dev   devtmpfs devtmpfs rw,nosuid,noexec,size=8144964k,nr_inodes=2036241,mode=755,inode64

now try to imagine --target is the default, you will get always any
answer for arbitrary path ... IMHO very confusing for many users.


I have doubts we can change this default behavior due to backward
compatibility (yes, the proper way how to use findmnt in scripts is to
use --target, --sources or --mountpoint, but people do not use it
...).

It would be probably better to introduce a small new util "path2fs" to
get mountpoint (or source), but without any other findmnt functionality.

We have mountpoint(1), but it returns TRUE/FALSE if the given path is
a mountpoint.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

