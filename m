Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51595 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757449AbbEELDe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 5 May 2015 07:03:34 -0400
Date: Tue, 5 May 2015 13:03:31 +0200
From: Karel Zak <kzak@redhat.com>
To: Michael Marineau <michael.marineau@coreos.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: (gpt) fix check for beginning of protective
 partition
Message-ID: <20150505110331.GF27969@ws.net.home>
References: <1430541873-27791-1-git-send-email-michael.marineau@coreos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430541873-27791-1-git-send-email-michael.marineau@coreos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 01, 2015 at 09:44:33PM -0700, Michael Marineau wrote:
> Search for the protective partition before attempting to validate that
> it covers the GPT header. Some hybrid MBRs list partitions out of order.
> For example, CoreOS images ship with a hybrid MBR that lists the boot
> partition first and the protective partition second in order to maintain
> compatibility with old versions of Xen's PV-GRUB.

 IMHO is better to say "sorry, this is unsupported use-case", than
 really on bad thing like hybrid GPT.

 Anyway applied, with your patch the code seems more robust, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
