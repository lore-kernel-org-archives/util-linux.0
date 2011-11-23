Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2100 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755122Ab1KWNM5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 23 Nov 2011 08:12:57 -0500
Date: Wed, 23 Nov 2011 14:12:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Cc: util-linux@vger.kernel.org
Subject: Re: small bug in mkfs.cramfs + patch
Message-ID: <20111123131253.GB11144@nb.net.home>
References: <4EC53E48.5010008@invoxia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC53E48.5010008@invoxia.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 17, 2011 at 06:03:04PM +0100, Arnaud Mouiche wrote:
>         $ cd /tmp
>         $ mkdir content
>         $ echo hello > content/a
>         $ echo hello > content/b
>         $ mkfs.cramfs content content.cramfs
>         not enough space allocated for ROM image (4090 allocated, 4096  

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
