Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32692 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757439Ab1GKIvc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Jul 2011 04:51:32 -0400
Date: Mon, 11 Jul 2011 10:51:29 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/3] mkfs.minix: add minix v3 support
Message-ID: <20110711085129.GC5214@nb.net.home>
References: <1309368495.3162.4.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309368495.3162.4.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 29, 2011 at 01:28:15PM -0400, Davidlohr Bueso wrote:
>  disk-utils/Makefile.am  |    2 +-
>  disk-utils/mkfs.minix.c |  142 ++++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 110 insertions(+), 34 deletions(-)

 Applied with some changes, thanks.

> +static int *super_set_state_ptr(void)
> +{
> +	switch (fs_version) {
> +	case 3:
> +		Super3.s_state |= MINIX_VALID_FS;
> +		Super3.s_state &= ~MINIX_ERROR_FS;
> +		break;
> +	default:
> +		Super.s_state |= MINIX_VALID_FS;
> +		Super.s_state &= ~MINIX_ERROR_FS;
> +		break;
> +	}

[...]

> +	int *state = super_set_state_ptr();

 This does not make sense. The function does not return anything and
 the 'int *state' is not used. Fixed (but not tested), see the git
 repository.

 It would be nice to have tests/ts/minix/mkfs-v{2,3} ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
