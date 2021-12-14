Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9F8C433F5
	for <util-linux@archiver.kernel.org>; Tue, 14 Dec 2021 12:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhLNMEA (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Dec 2021 07:04:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233738AbhLNMD7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Dec 2021 07:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639483439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eq9/bcISpirOoeGwHPVaCJrF0r1Sz1Eaj33r8L26yUw=;
        b=d3/h+y+yhAAedU/vdBZ39LwCI+e4VG7sNE5wlQiCOE2ACR8CRumxTKnfyqL3nu+gOc68lK
        MkmJjy/3I+ddk9/9vBppVwqcqRDmeh9hMH2OAMLpFPeQwblMZUM3PuLfPArzkKTzBQVUI7
        wRSeZGfKH+CRyjx8lCEO4Vyo52qnPjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-4WxkIR5GO3WJha9UtZMB_w-1; Tue, 14 Dec 2021 07:03:56 -0500
X-MC-Unique: 4WxkIR5GO3WJha9UtZMB_w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 866FC1F2DB;
        Tue, 14 Dec 2021 12:03:54 +0000 (UTC)
Received: from ws.net.home (ovpn-112-15.ams2.redhat.com [10.36.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE29E1001F4D;
        Tue, 14 Dec 2021 12:03:52 +0000 (UTC)
Date:   Tue, 14 Dec 2021 13:03:49 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc:     util-linux@vger.kernel.org, jkosina@suse.cz, kurt@garloff.de,
        den@openvz.org, msuchanek@suse.de, efremov@linux.com
Subject: Re: [PATCH 2/2] libblkid: reopen floppy without O_NONBLOCK
Message-ID: <20211214120349.kntr7gza5flma5tc@ws.net.home>
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
 <20211209141233.3774937-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209141233.3774937-3-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Hi Vladimir,

On Thu, Dec 09, 2021 at 03:12:33PM +0100, Vladimir Sementsov-Ogievskiy wrote:
> Note, that this commit is done as a "minimal change", i.e. I only try to
> rollback O_NONBLOCK for floppy. The other way is to detect CDROM
> instead, and reopen with original flags for everything except CDROM.
> 
> I also tried fcntl instead of close/open, and that didn't help.

What does it mean didn't help?             

I guess that drop O_NONBLOCk in blkid_probe_set_device() for floppies
would be enough, something like:           

int blkid_probe_set_device(blkid_probe pr, int fd,  
                blkid_loff_t off, blkid_loff_t size)
{                                          
   ...                                     

    if (ioctl(fd, FDGETDRVTYP, &name) >= 0) {       
        int flags;                         

        if ((flags = fcntl(fd, F_GETFL, 0)) != -1)  
            fcntl(fd, F_SETFL, flags & ~O_NONBLOCK);          
    }                                      
   ...                                     
}                                          

Yes, it's a little bit dirty to modify FD in the library (if the FD is
provided by the application), but if O_NONBLOCK is wrong in all cases for
floppies, then it seems like a good thing.    

This solution will fix the problem without libblkid API change, and it
will fix it in all current applications.   

The solution based on blkid_safe_open() means that we have to modify
many applications. For example, systemd/udevd uses   
                                           

    fd = open(devnode, O_RDONLY|O_CLOEXEC|O_NONBLOCK);              
    r = blkid_probe_set_device(pr, fd, offset, 0);            

The same is probably in many other places (mkfs-like programs, etc.).

What do you think?

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

