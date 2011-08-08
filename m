Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36028 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752079Ab1HHLv5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Aug 2011 07:51:57 -0400
Date: Mon, 8 Aug 2011 13:51:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] Documentation: add debugging doc
Message-ID: <20110808115154.GM2204@nb.net.home>
References: <1312678772.3408.3.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312678772.3408.3.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Aug 06, 2011 at 08:59:32PM -0400, Davidlohr Bueso wrote:
> From: Davidlohr Bueso <dave@gnu.org>
> 
> Layout the base for tips on debugging util-linux programs/wrappers.
> 
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>
> ---
>  Documentation/README.debug |   30 ++++++++++++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/README.debug

 I'll merge this change after v2.20 stable release. The v2.20 will be
 without the Documentation/ directory.

> +When this command is run, there's a library dependency error:
> +./mount: /lib/x86_64-linux-gnu/libblkid.so.1: version `BLKID_2.20' not found (required by ./mount)

 BTW, for mount I sometimes use --enable-static-programs and then
 mount/mount.static which is out of the libtool control :-)

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
