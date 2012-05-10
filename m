Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56358 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758276Ab2EJJvS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 May 2012 05:51:18 -0400
Date: Thu, 10 May 2012 11:50:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/5] fdisk: move DOS new/add partition code
Message-ID: <20120510095052.GC25706@x2.net.home>
References: <1336306218.2685.11.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336306218.2685.11.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 06, 2012 at 02:10:18PM +0200, Davidlohr Bueso wrote:
>  fdisk/fdisk.h         |   22 +++-
>  fdisk/fdiskdoslabel.c |  332 ++++++++++++++++++++++++++++++++++++++++++++++
>  fdisk/fdiskdoslabel.h |    5 +-
>  4 files changed, 365 insertions(+), 348 deletions(-)

 Applied, thanks.

> +extern unsigned long long total_number_of_sectors;

 Look forward to see sector_t :-)

> +static inline int is_cleared_partition(struct partition *p)
> +{
> +	return !(!p || p->boot_ind || p->head || p->sector || p->cyl ||
> +		 p->sys_ind || p->end_head || p->end_sector || p->end_cyl ||
> +		 get_start_sect(p) || get_nr_sects(p));
> +}

 this seems DOS specific...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
