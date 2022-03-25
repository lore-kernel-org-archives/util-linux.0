Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45308C433F5
	for <util-linux@archiver.kernel.org>; Fri, 25 Mar 2022 08:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242892AbiCYIaL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 25 Mar 2022 04:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242775AbiCYIaJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 25 Mar 2022 04:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C6C1BB6
        for <util-linux@vger.kernel.org>; Fri, 25 Mar 2022 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648196915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l5DHpHniuGJhhuS8cFXyvL6js0m9tAMKDTaPiQ9fYDs=;
        b=he9c438WeGpBZ5M9P2QrDehApMCa9j6G2HLs+BW3kNCYsyNt5yrjuQbcGoRPZtFi0hI1tU
        +/dEddg8dG4VvwY1Z1iO9bEjWu5vuJ4rjHhY/SDoDT1SsL16A8f3rlvu/6EchAxTSg3uUk
        4irOAYhfmJSIjUYeqAUxSoM+SVnJhhU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-jZL6OOsTMYOuZm5oMdoQmQ-1; Fri, 25 Mar 2022 04:28:32 -0400
X-MC-Unique: jZL6OOsTMYOuZm5oMdoQmQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEB1085A5A8;
        Fri, 25 Mar 2022 08:28:31 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5444D54B99E;
        Fri, 25 Mar 2022 08:28:31 +0000 (UTC)
Date:   Fri, 25 Mar 2022 09:28:29 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] flock(1): Decribe limitations of flock: deadlock, NFS,
 CIFS
Message-ID: <20220325082829.gsmijcglm3bqtozy@ws.net.home>
References: <aeb70bf3-cda5-a3a2-9b38-156c79d39b0b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeb70bf3-cda5-a3a2-9b38-156c79d39b0b@suse.cz>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Mar 24, 2022 at 01:27:14AM +0100, Stanislav Brabec wrote:
>  sys-utils/flock.1.adoc | 6 ++++++
>  1 file changed, 6 insertions(+)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

