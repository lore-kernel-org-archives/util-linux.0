Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18282 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755011AbaFZKKQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jun 2014 06:10:16 -0400
Date: Thu, 26 Jun 2014 12:10:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: fallocate: --punch option parsing error diagnostics irritating
Message-ID: <20140626101009.GD30418@x2.net.home>
References: <53AB2E36.5060405@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53AB2E36.5060405@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 25, 2014 at 10:16:54PM +0200, Bernhard Voelker wrote:
>   $ ./fallocate -p -l 10000 /tmp/x
>   fallocate: only -n mode can be used with --zero-range
> 
> Huh? I didn't specify neither -n nor -z.

		case 'p':
			mode |= FALLOC_FL_PUNCH_HOLE;
			/* fall through */
		case 'n':
			mode |= FALLOC_FL_KEEP_SIZE;
			break;


unfortunately there is nothing about it in man page and usage(). It's
described in fallocate(2) syscall man page only.

Anyway, the code is wrong, it assumes that KEEP_SIZE is possible to use
only with ZERO_RANGE. 

Fixed in git tree, man page massively modified to be readable for
humans (original text in the man page was from FS devels:-)

> Finally, please add some examples to the man page.

I think the new version of the man page is good enough without examples, but 
if someone has something nice we can add EXAMPLES section.

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
