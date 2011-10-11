Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58789 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752266Ab1JKK0O (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 11 Oct 2011 06:26:14 -0400
Date: Tue, 11 Oct 2011 12:26:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/6] chcpu und lscpu updates
Message-ID: <20111011102609.GD20392@nb.net.home>
References: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318237184-6616-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 10, 2011 at 10:59:38AM +0200, Heiko Carstens wrote:
> just some more small updates for chcpu and lscpu. The main part are
> the man pages updates. Hopefully for the better :)

 Applied, thanks.

>   lscpu: switch Yes/No output to lower case
>   lscpu: fix typo in help text
>   lscpu: change column names back to mixed case

 Fixed, I have also added columns description to the --help output
 (like we already use for lsblk, findmnt, partx, ...).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
