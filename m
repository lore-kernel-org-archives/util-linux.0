Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13175 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898Ab1F0OXo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Jun 2011 10:23:44 -0400
Date: Mon, 27 Jun 2011 16:23:41 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] mkfs.minix: check for misalignment
Message-ID: <20110627142341.GB14747@nb.net.home>
References: <1308625906.3690.2.camel@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308625906.3690.2.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 20, 2011 at 11:11:46PM -0400, Davidlohr Bueso wrote:
>  disk-utils/mkfs.minix.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

 Applied with a small change, thanks.

> @@ -653,6 +653,11 @@ int main(int argc, char ** argv) {
>  		DEV = open(device_name,O_RDWR | O_EXCL);
>  	else
>  		DEV = open(device_name,O_RDWR);
> +
> +	if (blkdev_is_misaligned(DEV))
> +		warnx(_("warning: %s is misaligned"), device_name);

 It makes sense for block devices only.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
