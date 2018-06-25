Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:33859 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934325AbeFYOwY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 25 Jun 2018 10:52:24 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0M7TQZ-1gLSsL3zGR-00xIQ4 for <util-linux@vger.kernel.org>; Mon, 25 Jun 2018
 16:52:23 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] ipcs,chmem: fix access() usage
Date: Mon, 25 Jun 2018 16:52:21 +0200
References: <20180625121831.14610-1-sweet_f_a@gmx.de>
In-Reply-To: <20180625121831.14610-1-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201806251652.21950.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I've submitted this and 2 more trivial fixes via github
https://github.com/karelzak/util-linux/pull/653

On Monday 25 June 2018, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> Some mistakes happened lately when switching from path_exist()
> to ul_path_access(). See f09a98de and 8ca31279.
>
> This caused ipcs tests failures when running i386 binaries on x86_64
> hosts, because the syscall fallback was always used. That's why I
> reviewed all similar changes and found another one in chmem.
>
