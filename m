Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-io0-f175.google.com ([209.85.223.175]:34238 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125AbbKSCVi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 18 Nov 2015 21:21:38 -0500
Received: by ioir85 with SMTP id r85so74919415ioi.1
        for <util-linux@vger.kernel.org>; Wed, 18 Nov 2015 18:21:38 -0800 (PST)
Received: from localhost ([2001:cc0:201e:102:3e97:eff:fea9:6aa7])
        by smtp.gmail.com with ESMTPSA id r15sm2483613ioi.38.2015.11.18.18.21.36
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2015 18:21:37 -0800 (PST)
From: "Casper Ti. Vector" <caspervector@gmail.com>
Date: Thu, 19 Nov 2015 10:21:34 +0800
To: util-linux@vger.kernel.org
Subject: Re: udevil - mount tool
Message-ID: <20151119022134.GA27094@CasperVector>
References: <n2ibqp$ui6$1@ger.gmane.org>
 <564CC253.2080301@gmail.com>
 <20151119010838.GA16043@CasperVector>
 <n2ja20$1sf$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <n2ja20$1sf$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> % udevil mount -o bind /dev/sdb1
> udevil: denied 90: option 'bind' is not an allowed option

Since the package is provided on you distro, you can install it and then
search for `allowed_options' in /etc/udevil/udevil.conf (or somewhere
like that; distros sometimes modify installation paths).  I think the
default policy is already reasonable; you can still fine-tune it if
necessary, since the mechanism is quite flexible.

On Thu, Nov 19, 2015 at 02:53:04AM +0100, U.Mutlu wrote:
> Do you happen to know if it has some dangerous options like "bind-mounting" 
> like the standard "mount" pgm has?
> Bind-mounting is a big security risk, really, and that's the sole
> reason I was looking for an alternate mount tool for non-root users.

-- 
My current OpenPGP key:
RSA4096/0x227E8CAAB7AA186C (expires: 2020.10.19)
7077 7781 B859 5166 AE07 0286 227E 8CAA B7AA 186C

