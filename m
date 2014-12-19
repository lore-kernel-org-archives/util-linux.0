Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51373 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbaLSJJ3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 19 Dec 2014 04:09:29 -0500
Date: Fri, 19 Dec 2014 10:09:25 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: util-linux@vger.kernel.org
Subject: Re: RFC [patch] adding docstrings
Message-ID: <20141219090925.GI19904@x2.net.home>
References: <1418847631-8317-1-git-send-email-bensberg@justemail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418847631-8317-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 17, 2014 at 09:20:31PM +0100, Benno Schulenberg wrote:
> For mkfs.cramfs, mkfs.minix, blkid and chrt I've had to
> improvise -- putting the docstring before the synopis -- in order to
> avoid making extensive changes to the usage text; those changes will
> come later.)

hmm.. it would be better to be consistent and add the docstring to the
same position in all utils. (IMHO the best position is between
"usage:" and "options:" line.)

> can improve its description.  Other improvements and comments are
> welcome too.

you forgot _() NLS macro:

> +	fputs("Tell the kernel about the existence of a specified partition.\n", out);

should be:

    fputs(_("Tell the kernel about the existence of a specified partition.\n"), out);


Anyway, good work!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
