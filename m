Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f46.google.com ([209.85.215.46]:52450 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755334Ab2JVREI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Oct 2012 13:04:08 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1756128lag.19
        for <util-linux@vger.kernel.org>; Mon, 22 Oct 2012 10:04:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1350925048-31084-1-git-send-email-venkat@linaro.org>
References: <1350925048-31084-1-git-send-email-venkat@linaro.org>
Date: Mon, 22 Oct 2012 22:34:06 +0530
Message-ID: <CAFSEfh03NHoWjWh2A0wx_eu8xZFvzU6jvRpLtmF-uYxNUwTE3A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Adding useful information into swap partition header
From: Venkatraman S <venkat@linaro.org>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org, arnd.bergmann@linaro.org,
        Venkatraman S <venkat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 22 October 2012 22:27, Venkatraman S <venkat@linaro.org> wrote:
> Trying some of the ideas bounced around in lkml for
> optimizing swap on flash (eMMC / SD) media [1], we can start
> to add useful information into swapheader without breaking
> compatibility.
> Such information can help the kernel swap management algo
> to tune itself to the geometry of flash devices (erase block
> size and page size etc).
> Some more features (like command line override) are still
> under development. In long term, libblkid/mkswap can be extended
> to even detect this information by timing attacks,
> even if sysfs parameters are not present.
>
Oops: Some reference links were missed in the cover letter..

[1] https://lkml.org/lkml/2012/3/30/410
