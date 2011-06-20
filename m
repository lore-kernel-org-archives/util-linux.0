Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:8571 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761Ab1FTKy3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 20 Jun 2011 06:54:29 -0400
Date: Mon, 20 Jun 2011 12:54:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lscpu: detect VMware hypervisor
Message-ID: <20110620105427.GA23425@nb.net.home>
References: <20110616165407.00c4d7ab@s6510.ftrdhcpuser.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110616165407.00c4d7ab@s6510.ftrdhcpuser.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 16, 2011 at 04:54:07PM -0400, Stephen Hemminger wrote:
> Add detection of VMware.
> Tested on VMware Workstation 7.1.4
> ---
>  sys-utils/lscpu.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)

 Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
