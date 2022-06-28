Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007D4C43334
	for <util-linux@archiver.kernel.org>; Tue, 28 Jun 2022 12:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345403AbiF1MHg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 28 Jun 2022 08:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241606AbiF1MHf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 28 Jun 2022 08:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A01033360
        for <util-linux@vger.kernel.org>; Tue, 28 Jun 2022 05:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656417981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PztcW36yk5Vfh3GDkalVGzultiOVQLo9HUq2DKqfKFQ=;
        b=JthxmZH/ZMVrFdG5TId9ibULhQfNC9eIKbdSIeyTWWmurvRUaofsDJPka3kDfGmd8S4XWG
        UXL/7cPvpZ9qFpaFdl5ZmGdajxMA+60fpwvsL+Q1s8otuVOCZjtviXB11k+x4JdJy+x1kA
        4hysxDg4og+ZO9Tmyvb+v0mp5FwItho=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-ijsgwjwzO-yBXd_wxxQVtQ-1; Tue, 28 Jun 2022 08:06:19 -0400
X-MC-Unique: ijsgwjwzO-yBXd_wxxQVtQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E36C93833286;
        Tue, 28 Jun 2022 12:06:18 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68662492C3B;
        Tue, 28 Jun 2022 12:06:18 +0000 (UTC)
Date:   Tue, 28 Jun 2022 14:06:16 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Michael Trapp <michael.trapp@sap.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] Implement continuous clock handling for time based UUIDs
Message-ID: <20220628120616.glrwy7iqfepgrwap@ws.net.home>
References: <20220620151036.97706-1-michael.trapp@sap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620151036.97706-1-michael.trapp@sap.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jun 20, 2022 at 05:10:36PM +0200, Michael Trapp wrote:
> In a uuidd setup, the daemon is a singleton and can maintain it's own
> resources for time based UUID generation. This requires a dedicated
> 'clock sequence range' but does not need any further lock/update of
> the LIBUUID_CLOCK_FILE from uuidd. The range of available clock values
> is extended by a continuous handling of the clock updates - instead of
> updating the value to the current timestamp, it is incremented by
> the number of requested UUIDs.
> ---
> 
> Updated version
>   cont clock handling needs to be activated with '-C' or '--cont-clock'.
>   default value of max_clock_offset is 7200 seconds.
>   custom value of max_clock_offset can be defined by optional argument.
>   maximum value of max_clock_offest is 365 days.

Looks good, thanks! I'll apply the patch later this week.

BTW, by the reset interval is 7200 seconds? Why not 3600? :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

