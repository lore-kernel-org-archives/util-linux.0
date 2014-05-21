Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:50174 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753372AbaEUW3Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 21 May 2014 18:29:16 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] lscpu: improve hypervisor detection
Date: Thu, 22 May 2014 00:29:12 +0200
Cc: Stanislav Brabec <sbrabec@suse.cz>, Petr Uzel <petr.uzel@suse.cz>
References: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1400600551-7227-1-git-send-email-sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201405220029.12635.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 20 May 2014, Ruediger Meier wrote:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> This patch set is based on an openSUSE / SLE patch. Original author
> was probably Petr Uzel.
>
> I've splitted the original patch into smaller pieces, removed some
> incompatible output format changes and added some test data.

I have updated these patches on github
https://github.com/karelzak/util-linux/pull/87

changes since v1:
* separate read_hypervisor_powerpc function:
 - fopen -> path_fopen
 - it works now for SYSTEM_SNAPSHOT and not only ifdef __powerpc_
*VMWARE_BDOOR:
 - cleanup ifdefs
 - attribute unused
 - must be only called if not SYSTEM_SNAPSHOT

Note VMWARE_BDOOR breaks travis build for (old) clang. To be fixed later 
via ifdef or just for travis.

cu,
Rudi
