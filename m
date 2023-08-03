Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D97C04A6A
	for <util-linux@archiver.kernel.org>; Thu,  3 Aug 2023 10:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjHCKSV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 3 Aug 2023 06:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbjHCKRi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 3 Aug 2023 06:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59A53C16
        for <util-linux@vger.kernel.org>; Thu,  3 Aug 2023 03:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691057783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y8R5FGUH6fmz0Aj0qoBu11TLyLhrBvv33VvVGOgwvSE=;
        b=TaqUSpOwo+Wsxggye99okxT5cfPH7l7uJ0tH2W4gOz4+zINKTOfyZr0JGzg9sri0MHo2Dh
        AhDRDXaR4x0YDLcpoXHd4CfL2O1BiZSB/Tapy7pel/XS8fyrSpC5Ax4BOWcucE7oMUUJXG
        aNW6zBpViO0H3fYJ7Ws3Z6TO+8C2ib8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-m7-qb8KDOkyTI5W5xZJb7w-1; Thu, 03 Aug 2023 06:16:19 -0400
X-MC-Unique: m7-qb8KDOkyTI5W5xZJb7w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FADB80027F;
        Thu,  3 Aug 2023 10:16:19 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A4AD40C6CCC;
        Thu,  3 Aug 2023 10:16:18 +0000 (UTC)
Date:   Thu, 3 Aug 2023 12:16:16 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Markus Mayer <mmayer@broadcom.com>
Cc:     util-linux mailing list <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/2] Improved libmount configure checks
Message-ID: <20230803101616.6lk3kvhjtc2vsv43@ws.net.home>
References: <20230801195927.43090-1-mmayer@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801195927.43090-1-mmayer@broadcom.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Aug 01, 2023 at 12:59:25PM -0700, Markus Mayer wrote:
> Markus Mayer (2):
>   libmount: check for linux/mount.h
>   libmount: check for struct statx

Applied, thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

