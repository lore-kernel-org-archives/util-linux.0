Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54364C6FA9D
	for <util-linux@archiver.kernel.org>; Wed,  1 Mar 2023 17:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjCARzd (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Mar 2023 12:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCARzc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Mar 2023 12:55:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692CE271A
        for <util-linux@vger.kernel.org>; Wed,  1 Mar 2023 09:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677693288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tXCmMdVMkjejVR3Nw0Iau3zULAAO55nqiN1h4qGdUP4=;
        b=C2E2i4oJUeNWG9esPkhpAS5JU0zHpHK05QFSNvSMgYRJOq0wAvWiepBFIMifOzzCqbIlJ1
        eOIDcZ3IijZMOBcKNMRuJoA+ckRXFbIKBKnexbIuCKGSGIWx4C8AciuqlsWVO2QDjuGedQ
        ymsMzIYruDWnMw12MW8Tle0ypXzvqs4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-bvWtn_nUNW68nS1CL1BhYA-1; Wed, 01 Mar 2023 12:54:47 -0500
X-MC-Unique: bvWtn_nUNW68nS1CL1BhYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF9DC2810C0F;
        Wed,  1 Mar 2023 17:54:45 +0000 (UTC)
Received: from ws.net.home (ovpn-192-20.brq.redhat.com [10.40.192.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62BDA2026D76;
        Wed,  1 Mar 2023 17:54:45 +0000 (UTC)
Date:   Wed, 1 Mar 2023 18:54:43 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: Move clock.txt to /run
Message-ID: <20230301175443.lpcx7up35eo5wwdg@ws.net.home>
References: <20230301140957.21604-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301140957.21604-1-msuchanek@suse.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Mar 01, 2023 at 03:09:57PM +0100, Michal Suchanek wrote:
> Some users complain that due to filesystem performance of writing the
> clock.txt generating UUIDs is slow.

XFS right? ;-)

> uuidd would solve this but some distributions do not run it by default.

For some performance critical use-cases you will see this issue with
uuidd too. The latest changes in the libuuid and uuidd solves this
problem by continuous-clock where uuidd uses dedicated clock sequence
range to avoid often state-file updates. 

Numbers from Michael (author of the patch)

 The classic setup delivered <430.000 uuid/sec on average.
 The cont-clock setup delivered >6.800.000 uuid/sec on average.

I hope we will have -rc1 with this change this week.

Note that generate large number of time-based UUIDs without uuidd does
not make sense.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

