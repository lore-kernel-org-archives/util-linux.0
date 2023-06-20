Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12DEEB64D7
	for <util-linux@archiver.kernel.org>; Tue, 20 Jun 2023 09:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjFTJ3X (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 20 Jun 2023 05:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjFTJ3V (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 20 Jun 2023 05:29:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB9ED1
        for <util-linux@vger.kernel.org>; Tue, 20 Jun 2023 02:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687253313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bL9Hdp1FH6Ga397+x2CALp1CRzBbteSCsKDxJ+6rVVw=;
        b=Pw3zsy+tQXlBZ4w3WHH0k5oEw659EYzG0Ie/Q+tqF1zLXNRGOGT5uS+0sd/NIUrqwcO4qE
        3ifBIp6SiT59jfgB5nC2KnVU1DFkFFN0Sj0tWtmQb/6R5OUSv8pN21aEKHy9ybN119iil4
        J5SoHC/nHK/Qf8g1yvHrh9FMI6Zt1lg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-U_zofkGSPx2Lba-UNlOoZg-1; Tue, 20 Jun 2023 05:28:30 -0400
X-MC-Unique: U_zofkGSPx2Lba-UNlOoZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F19B2A59551;
        Tue, 20 Jun 2023 09:28:30 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B70D2166B26;
        Tue, 20 Jun 2023 09:28:29 +0000 (UTC)
Date:   Tue, 20 Jun 2023 11:28:27 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] sys-utils: fix SELinux context example in mount.8
Message-ID: <20230620092827.exezx6ap3klzvibu@ws.net.home>
References: <20230618212911.549645-1-tmz@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230618212911.549645-1-tmz@pobox.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Jun 18, 2023 at 05:29:11PM -0400, Todd Zullinger wrote:
>  sys-utils/mount.8.adoc | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

