Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ACEC433FE
	for <util-linux@archiver.kernel.org>; Fri, 29 Apr 2022 08:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356126AbiD2Irf (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 29 Apr 2022 04:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356039AbiD2IrZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 29 Apr 2022 04:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A305DC44C1
        for <util-linux@vger.kernel.org>; Fri, 29 Apr 2022 01:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651221820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ohk0sL/L3pvgS9U2SQCxzriuuaXkYdJYEB3I/ivIW+Q=;
        b=SfbZExUUTJqCYmk/aGlNt6SNCl0ezkgrHsRNti6pVS2rN4Y4oypuU9DhrD8GcMtFQJcogz
        eUBoXt8qx0QJyMbsOS7P+tcdRCVX8COQpc8AswJmTaptJsa1Xenk3z/RmkyPOJUH9TfXzH
        6Mp5Iocgir4s9lTJVnnqPiFs0U2+MK8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-mZtpn3hPO3OVJs-6aazUMw-1; Fri, 29 Apr 2022 04:43:39 -0400
X-MC-Unique: mZtpn3hPO3OVJs-6aazUMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AAFE851780
        for <util-linux@vger.kernel.org>; Fri, 29 Apr 2022 08:43:36 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A48B240869DA;
        Fri, 29 Apr 2022 08:43:35 +0000 (UTC)
Date:   Fri, 29 Apr 2022 10:43:33 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>, esandeen@redhat.com,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 0/2] libblkid: add FSSIZE with XFS implementation
Message-ID: <20220429084333.m6vcxptlvusgotvr@ws.net.home>
References: <20220421130946.318737-1-aalbersh@redhat.com>
 <20220425134329.ub3thxkscsniy74e@ws.net.home>
 <8b2a82b2-8890-1276-9948-d8c28fca3d9b@redhat.com>
 <20220426082104.fojzjdfprbb2dth7@ws.net.home>
 <YmfPPbgZtZi1iSXv@aalbersh.remote.csb>
 <facb3c36-0088-d645-6162-4d52fc94557f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <facb3c36-0088-d645-6162-4d52fc94557f@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Apr 26, 2022 at 11:10:12PM -0500, Eric Sandeen wrote:
> Ok, so I'm remembering what FSSIZE does in lsblk now :) it simply returns:
> 
> 	dev->fsstat.f_frsize * dev->fsstat.f_blocks
> 
> i.e. calculating the value based on statfs values.
> 
> This does get a little tricky for ext4, because statfs "f_blocks" is
> affected by the minixdf/bsddf mount options.
> 
> ext4's f_blocks statfs calculation looks like this:
> 
>         buf->f_blocks = ext4_blocks_count(es) - EXT4_C2B(sbi, overhead);
> 
> the default behavior, bsddf, subtracts out the overhead.

Note. There is no problem add to the man page(s) information that
FSSIZE may be different to numbers from statfs() or df(1). It does not
have to be perfect, but good enough to get basic overview about FS. It
does not make sense to assume that libblkid is able to work with FS
like kernel.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

