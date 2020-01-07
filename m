Return-Path: <SRS0=/iJD=24=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A37C33C8C
	for <util-linux@archiver.kernel.org>; Tue,  7 Jan 2020 16:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7B72080A
	for <util-linux@archiver.kernel.org>; Tue,  7 Jan 2020 16:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjXeItSg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgAGQEt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:04:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43160 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728173AbgAGQEt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 7 Jan 2020 11:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578413089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CHnr2EeThbIq/qxKe4JjZeGgACEOyf+/24Wt1zJ9t9g=;
        b=UjXeItSgwLYE4JbNOHnydCqjaPFkrlgf7M39CBerSA9zfjtqcajr1TU93/Yvy07KcyENpH
        i51jjemGULKVRdD1v9ptAdaZao1hgWTqQ5WAo2JOLNnKkY27FJHA8RlI3JHG8HBOdaSkM+
        7KQvPExxDPmcgQJMfqiA7Q1XUjfVIzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-NrWkYFZAOu6Gr5j-aWw1xA-1; Tue, 07 Jan 2020 11:04:47 -0500
X-MC-Unique: NrWkYFZAOu6Gr5j-aWw1xA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FC80800D4C;
        Tue,  7 Jan 2020 16:04:46 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-196.brq.redhat.com [10.40.204.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BDDD79CA3;
        Tue,  7 Jan 2020 16:04:45 +0000 (UTC)
Date:   Tue, 7 Jan 2020 17:04:43 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: open device in nonblock mode.
Message-ID: <20200107160443.y72na25i5fk72zqt@10.255.255.10>
References: <20191104202315.4879-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104202315.4879-1-msuchanek@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Nov 04, 2019 at 09:23:15PM +0100, Michal Suchanek wrote:
> When autoclose is set (kernel default but many distributions reverse the
> setting) opening a CD-rom device causes the tray to close.

I found unwanted side effect, open() with O_NONBLOCK also successes
when there is no medium. Unfortunately, we ignore I/O errors for
CDROMs to support some crazy hybrid media -- so overall result is many
I/O warnings in system logs.

I have added CDROM_DRIVE_STATUS to the logic to stop probing when
there is no medium. Let's hope it will be enough:

https://github.com/karelzak/util-linux/commit/dc30fd4383e57a0440cdb0e16ba5c4336a43b290


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

