Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37689 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756343AbbKSBIn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 18 Nov 2015 20:08:43 -0500
Received: by igcto18 with SMTP id to18so52192979igc.0
        for <util-linux@vger.kernel.org>; Wed, 18 Nov 2015 17:08:42 -0800 (PST)
Received: from localhost ([2001:cc0:201e:102:3e97:eff:fea9:6aa7])
        by smtp.gmail.com with ESMTPSA id k83sm2386205iod.1.2015.11.18.17.08.40
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2015 17:08:41 -0800 (PST)
From: "Casper Ti. Vector" <caspervector@gmail.com>
Date: Thu, 19 Nov 2015 09:08:38 +0800
To: util-linux@vger.kernel.org
Subject: Re: RFC: usermount - a secure mount for unpriviledged users
Message-ID: <20151119010838.GA16043@CasperVector>
References: <n2ibqp$ui6$1@ger.gmane.org>
 <564CC253.2080301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <564CC253.2080301@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also udevil, which might be of particular interest if you happen to
pursue a system with light dependencies:
<https://ignorantguru.github.io/udevil/>.

On Wed, Nov 18, 2015 at 08:24:19PM +0200, Mantas Mikulėnas wrote:
> fwiw, udisks2 already lets you mount removable drives and loop devices
> under (/run)/media:
> 
>   $ udisksctl mount -b /dev/sdb4
>   $ udisksctl loop-setup -f ~/foo.img

-- 
My current OpenPGP key:
RSA4096/0x227E8CAAB7AA186C (expires: 2020.10.19)
7077 7781 B859 5166 AE07 0286 227E 8CAA B7AA 186C

