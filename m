Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5EAC433EF
	for <util-linux@archiver.kernel.org>; Tue,  1 Feb 2022 08:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbiBAIvr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 1 Feb 2022 03:51:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233828AbiBAIvq (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Feb 2022 03:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643705506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tnxc9vEF31LxzHzOkY3Tm8WhK5FD/QwIc50MRepiQks=;
        b=NB14oqY99imsw1s9qjL08Nisx9AGXnrPY40Z1sCel0wTVP3sy+eYaT8uyhbCYx0JheLe/A
        u5hQI2ibCgDZk39Xm0Ar2bXKl9hKaK3F6d2wHpn395NMTiBYBvLzX6oqMIBDanWSY30h9w
        iFmyifHsJa1a4FTV5/kKMddepE6XRcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-dVhCQ_vrNwmf-Ys9HMub8Q-1; Tue, 01 Feb 2022 03:51:45 -0500
X-MC-Unique: dVhCQ_vrNwmf-Ys9HMub8Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 250EC84DA41;
        Tue,  1 Feb 2022 08:51:44 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 756BE5E4B7;
        Tue,  1 Feb 2022 08:51:43 +0000 (UTC)
Date:   Tue, 1 Feb 2022 09:51:40 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim: Add fstab option x-fstrim.notrim
Message-ID: <20220201085140.2mjhxln3zvvx43tq@ws.net.home>
References: <823c644a-9eec-4832-0f52-e5e9419aad95@suse.cz>
 <20220131095517.ngxxlu3vb74orljy@ws.net.home>
 <55ff6182-f447-dd80-67f0-7e230c28712c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55ff6182-f447-dd80-67f0-7e230c28712c@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jan 31, 2022 at 11:35:19PM +0100, Stanislav Brabec wrote:
> My original patch contains 2 adoc chunks: one for -A, second for
> --listed-in. X-fstrim.notrim works for both. Was the omitting of the chunk
> for --listed-in intentional?

Ah, no. I have applied the patch manually as git-am had a problem with
your email. Fixed now.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

