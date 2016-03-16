Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43249 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965649AbcCPNSS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Mar 2016 09:18:18 -0400
Date: Wed, 16 Mar 2016 14:18:16 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/3] lscpu: Fix model and model name on Power Systems
Message-ID: <20160316131816.stnqh5jvqu3n5z75@ws.net.home>
References: <1458130699-25464-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458130699-25464-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Mar 16, 2016 at 01:18:16PM +0100, Ruediger Meier wrote:
>  sys-utils/lscpu.c                             | 35 +++++++++------------------
>  tests/expected/lscpu/lscpu-ppc-qemu           |  3 ++-
>  tests/expected/lscpu/lscpu-ppc64-POWER7       |  3 ++-
>  tests/expected/lscpu/lscpu-ppc64-POWER7-64cpu |  3 ++-
>  tests/expected/lscpu/lscpu-sparc64            |  1 +
>  tests/expected/lscpu/lscpu-x86_64-64cpu       |  2 +-
>  tests/expected/lscpu/lscpu-x86_64-dell_e4310  |  2 +-
>  7 files changed, 21 insertions(+), 28 deletions(-)

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
