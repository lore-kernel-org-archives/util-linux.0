Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbdCNKTi (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Mar 2017 06:19:38 -0400
Date: Tue, 14 Mar 2017 11:19:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: util-linux@vger.kernel.org, Teresa Remmet <t.remmet@phytec.de>
Subject: Re: Corrupt ext4 fs after creation
Message-ID: <20170314101935.zkewsqgjf2h7r3ir@ws.net.home>
References: <153de314-38ff-ad68-65d9-a292213b47f6@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <153de314-38ff-ad68-65d9-a292213b47f6@phytec.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 13, 2017 at 04:17:33PM +0100, Daniel Schultz wrote:
> we use the Yocto Project to create custom BSPs for a AM335x SoC. After they
> upgraded the e2fsprogs from 1.42.9 to 1.43 we run into problems with our
> ext4 root file system. During the first boot systemd checks the rootfs with
> fsck.ext4 and needs a restart beacause of an error.

 You want to ask at linux-ext4@vger.kernel.org mailing list :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
