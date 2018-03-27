Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753023AbeC0Q6V (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 27 Mar 2018 12:58:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4127A401DEA6
        for <util-linux@vger.kernel.org>; Tue, 27 Mar 2018 16:58:21 +0000 (UTC)
Date: Tue, 27 Mar 2018 18:58:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Tony Asleson <tasleson@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Clarification on blkid_do_safeprobe
Message-ID: <20180327165817.k4uhvloqdizdqwcb@ws.net.home>
References: <851d5595-3f7e-8198-5b23-fde793ec31fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <851d5595-3f7e-8198-5b23-fde793ec31fd@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 27, 2018 at 11:28:17AM -0500, Tony Asleson wrote:
> From looking at the documentation and the code for blkid_do_safeprobe
> it's not totally apparent to me that when the function returns -2
> (ambivalent) that there is any results which may be retrieved by
> utilizing blkid_probe_numof_values and blkid_probe_get_value.

After any error blkid_probe_get_value() behavior is undefined. If need
to rescan the device by blkid_do_probe() get all possible results. 

See for example misc-utils/blkid.c:print_udev_ambivalent() where we
compose ID_FS_AMBIVALENT= for udev.

> Any clarification on this would be appreciated.  Also, do you only get
> the -2 return if BLKID_SUBLKS_BADCSUM is set?

You can get -2 when there is more valid superblocks detected on the
same device. The flag BLKID_SUBLKS_BADCSUM may help, but it's not
requirement.

All depends on msfs-like tools, if the tool does not wipe the device
before it creates a new filesystem then you will see more superblocks.

It's unusual now, but years ago it was pretty common. For example it
was possible to create LUKS/VFAT and SWAP on the same device. You can
imagine what happen with our encrypted data after swapon.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
