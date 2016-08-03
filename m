Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45038 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754542AbcHCMIB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 3 Aug 2016 08:08:01 -0400
Date: Wed, 3 Aug 2016 13:57:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] lscpu: new --physical option and small improvements
Message-ID: <20160803115754.f2mlhowmszzsm3fi@ws.net.home>
References: <1469794416-97361-1-git-send-email-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469794416-97361-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 29, 2016 at 02:13:31PM +0200, Heiko Carstens wrote:
> Please note that the short option of "--physical" is "-y". If you are
> not happy with that one feel free to change it; I couldn't decide
> which character would make most sense and there isn't any existing
> tool with a similar option. So...

 :-)

> Heiko Carstens (5):
>   lscpu: add --physical option
>   lscpu: add parsable testcase with the --physical option
>   lscpu: only try to read sysfs attributes of present CPUs
>   lspcu: minor manpage improvement
>   lscpu: print correct number of threads per core if possible

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
