Return-Path: <SRS0=e0jN=25=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A56C00523
	for <util-linux@archiver.kernel.org>; Wed,  8 Jan 2020 10:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2999F20705
	for <util-linux@archiver.kernel.org>; Wed,  8 Jan 2020 10:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0FgP/Xv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgAHKiQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:38:16 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47326 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727272AbgAHKiQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 8 Jan 2020 05:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578479895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=McNFtCRyd0uLcr0MpXcFYvBNH/vbYBADBPOFmbrGxlc=;
        b=I0FgP/Xv//FX9Y0eez7hFQKUJ3gutIvC0qJht0HO6UuwKrCRiBJoe5WSxT+bLOQyU2OPiL
        GwBVzbjxv7pLL+4Pk3+MWSPKWAxJN/UtlnCpRCJPGOn8ZF2JTBtE8/nYGUC7opELjnZ/9w
        3rre1NLnH0Jnc0ZmOubEBnLZjcPNd6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-uyBo9BCtNpStiTDHHqITgw-1; Wed, 08 Jan 2020 05:38:14 -0500
X-MC-Unique: uyBo9BCtNpStiTDHHqITgw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79ABA10054E3;
        Wed,  8 Jan 2020 10:38:13 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-204-196.brq.redhat.com [10.40.204.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CE4E5D9E1;
        Wed,  8 Jan 2020 10:38:12 +0000 (UTC)
Date:   Wed, 8 Jan 2020 11:38:10 +0100
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.35-rc2
Message-ID: <20200108103810.6s45opguridzzp2q@10.255.255.10>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The util-linux release v2.35-rc2 is available at

    https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.35/

Feedback and bug reports, as always, are welcomed.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

