Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46641 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349AbcCVJeW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Mar 2016 05:34:22 -0400
Date: Tue, 22 Mar 2016 10:34:19 +0100
From: Karel Zak <kzak@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/1] lscpu: correct the Virtualization type on Xen
 DomU PV guest
Message-ID: <20160322093419.hn2ddqd4s2icq6st@ws.net.home>
References: <df8d39d6-caca-49a0-9173-9e284e2527ac@default>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <df8d39d6-caca-49a0-9173-9e284e2527ac@default>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 21, 2016 at 10:42:55PM -0700, Dongli Zhang wrote:
> As we discussed that we will use path_read_u64.  However, since
> path_read_u64 reads an unsigned number but we need to read in hex format, I
> use path_fopen and fscan instead. The patch first checks if the path does
> exist.  Otherwise, the code will report error that
> "/sys/hypervisor/properties/features" does not exist.

Ah, now I read this your email. Sooo... I reverted my path_exit()
from your code. Sorry ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
