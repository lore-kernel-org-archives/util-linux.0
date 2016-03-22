Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38032 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753182AbcCVJYJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Mar 2016 05:24:09 -0400
Date: Tue, 22 Mar 2016 10:24:07 +0100
From: Karel Zak <kzak@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/1] lscpu: correct the Virtualization type on Xen
 DomU PV guest
Message-ID: <20160322092407.kkeov7kjqcfhyek7@ws.net.home>
References: <1458625094-13267-1-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1458625094-13267-1-git-send-email-dongli.zhang@oracle.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 22, 2016 at 01:38:14PM +0800, Dongli Zhang wrote:
>  sys-utils/lscpu.c | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)

 Applied, thanks.
 
> +		if (desc->hyper == HYPER_XEN) {
                                   ^^^
 I have add && path_exist(_PATH_SYS_HYP_FEATURES) here.


 It would be nice to have  /sys & /proc dump from Xen in our
 regression tests (see tests/ts/lscpu/mk-input.sh). Unfortunately,
 the detection depends on CPUID, so dump is useless in this case. 

 We need to extend lscpu to read cpuid and uname information 
 from file if --sysroot (snapshot) is specified. (TODO for v2.29).

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
