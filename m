Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483D4C43334
	for <util-linux@archiver.kernel.org>; Thu, 21 Jul 2022 08:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiGUIX3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 21 Jul 2022 04:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiGUIX3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 21 Jul 2022 04:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5404C7E015
        for <util-linux@vger.kernel.org>; Thu, 21 Jul 2022 01:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658391807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=j+/LWiwBqpY/YS2icwFZY53Hg7898STK+SLXotg1+Ww=;
        b=dGaZofh12tGmwK25lUVXnO4RuM7k6Frobhp6hA6h+YapGSA//u3WuDmSM2fsguGQ/ct4Ca
        qpk/qoMK31vUCu0ne7gpYK6MIeE7szN9EldE3yQseSwpGl75YgnFrfNzQBTMXASiSasGYZ
        mUu9A72KjV5cTUq4x7wVcfMIGBIHBEo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-qQAPPqhGOjye8bvvebisUw-1; Thu, 21 Jul 2022 04:23:26 -0400
X-MC-Unique: qQAPPqhGOjye8bvvebisUw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC77A804191
        for <util-linux@vger.kernel.org>; Thu, 21 Jul 2022 08:23:25 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8037E1415118
        for <util-linux@vger.kernel.org>; Thu, 21 Jul 2022 08:23:25 +0000 (UTC)
Date:   Thu, 21 Jul 2022 10:23:23 +0200
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Subject: v2.38.1 tomorrow
Message-ID: <20220721082323.64swgexwrrbfpcne@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org



 Please,

 see and try stable/v2.38 branch
 https://github.com/util-linux/util-linux/tree/stable/v2.38

 This is what I want to release tomorrow as stable v2.38.1.

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

