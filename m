Return-Path: <SRS0=vFYQ=AZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F47C433E1
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 08:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F8A20BED
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 08:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ST2k96tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgGNIxq (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:53:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31057 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725820AbgGNIxq (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Jul 2020 04:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594716730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qRcznAulzoavz8vZlHEYRga+8v4y3vsfiPw1avi1RB8=;
        b=ST2k96tmjkzhMGORFxuD883jH+0pH8JZG2rduHpsdLaPg66yeVNzgcRhL5wJMgEvBpQxrW
        lkvIiDmaD/Cl6tfc/U5GKoUvtwykjTaO8hnS6nyvwF5XTopFroCjt+z+ZPNMr+JGqBLuOU
        /rDzHTXxfvKtbkJPc4c0yt8WJii+jfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-Qoa7yyQAMt2fWtxr2dFSxg-1; Tue, 14 Jul 2020 04:52:08 -0400
X-MC-Unique: Qoa7yyQAMt2fWtxr2dFSxg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6227880040A;
        Tue, 14 Jul 2020 08:52:07 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D3E119C4F;
        Tue, 14 Jul 2020 08:52:06 +0000 (UTC)
Date:   Tue, 14 Jul 2020 10:52:03 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] lsblk: Add SERIAL column to the SCSI output mode.
Message-ID: <20200714085203.zbsqdimal5ebgfmm@ws.net.home>
References: <20200712104048.89908-1-gmazyland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712104048.89908-1-gmazyland@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Jul 12, 2020 at 12:40:48PM +0200, Milan Broz wrote:
>  misc-utils/lsblk.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

