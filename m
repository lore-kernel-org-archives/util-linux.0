Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14419 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934579AbaEFKnW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 May 2014 06:43:22 -0400
Date: Tue, 6 May 2014 12:43:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Shakur Shams Mullick <shakursmullick@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 6/8] misc-utils/lsblk.c: add sorting support for lsblk
 command
Message-ID: <20140506104319.GM5962@x2.net.home>
References: <1399138888-7554-1-git-send-email-shakursmullick@gmail.com>
 <1399138888-7554-6-git-send-email-shakursmullick@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399138888-7554-6-git-send-email-shakursmullick@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, May 03, 2014 at 11:41:26PM +0600, Shakur Shams Mullick wrote:
> It adds support for sorting in lsblk command. sorting can be done by name(-c) or size(-z). For longoptions use --sort name or --sort size
> 
> e.g. lsblk -c
>      lsblk -q name
>      lsblk --sort size

IMHO it would be better to have a generic option

    lsblk --order-by <column>

and maybe sort-cuts --order-by-size and --order-by-name to sort by NAME
and SIZE columns. (or s/order/sort/ ...)

It will probably necessary to add info about compare function type
(number or string) to lsblk "struct colinfo".

Maybe we can also add scols_cmpstr_cells() and scols_cmpnum_cells() to
the library to avoid duplicate code.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
